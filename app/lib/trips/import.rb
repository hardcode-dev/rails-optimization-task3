module Trips
  class Import
    DEFAULT_TABLES_FOR_CLEAN = %w[buses buses_services cities services trips]

    def initialize(truncate_tables_command, seed_services_command)
      @truncate_tables_command = truncate_tables_command
      @seed_services_command = seed_services_command

      @cities = {}
      @buses = {}
      @buses_services = {}
    end

    def call(file_path: nil, tables_for_clean: nil)
      @file_path = file_path
      @tables_for_clean = tables_for_clean

      import
    end

    private

    attr_reader :truncate_tables_command, :seed_services_command, :file_path, :tables_for_clean

    def import
      clean_tables
      seed_bus_services
      process_file
      import_cities
      import_buses
      import_bus_services
    end

    def clean_tables
      tables = tables_for_clean || DEFAULT_TABLES_FOR_CLEAN

      truncate_tables_command.call(tables: tables)
    end

    def seed_bus_services
      @buses_services = seed_services_command.call
    end

    def process_file
      ActiveRecord::Base.transaction do
        trips_command = "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) \
        from stdin with csv delimiter ';'"

        ActiveRecord::Base.connection.raw_connection.copy_data trips_command do
          # TODO: Change file path
          file_stream = File.open(file_path, "r")
          chunk_size = 1_000
          streamer = Json::Streamer.parser(file_io: file_stream, chunk_size: chunk_size)

          streamer.get(nesting_level: 1) do |object|
            import_row(object)
          end
        end
      end
    end

    def import_row(row)
      from_city_id = fetch_city_id(row["from"])
      to_city_id = fetch_city_id(row["to"])
      bus_id = fetch_bus_id(row["bus"])

      connection = ActiveRecord::Base.connection.raw_connection
      connection.put_copy_data("#{from_city_id};#{to_city_id};#{row["start_time"]};#{row["duration_minutes"]};\
      #{row["price_cents"]};#{bus_id}\n")
    end

    def fetch_city_id(city_name)
      return @cities[city_name] if @cities[city_name]

      id = @cities.size + 1
      @cities[city_name] = id

      id
    end

    def fetch_bus_id(bus_info)
      bus_key = "#{bus_info["number"]} #{bus_info["model"]}"

      return @buses[bus_key][:id] if @buses[bus_key]

      id = @buses.size + 1
      bus_services_ids = [].tap do |x|
        bus_info["services"].each { |s| x << @buses_services[s] }
      end

      @buses[bus_key] = {
        id: id,
        services_ids: bus_services_ids,
        number: bus_info["number"],
        model: bus_info["model"],
      }

      id
    end

    def import_cities
      columns = [:id, :name]
      data = @cities.map { |name, id|
        [id, name]
      }

      City.import(columns, data)
    end

    def import_buses
      columns = [:id, :number, :model]
      data = @buses.map { |key, bus_data|
        [bus_data[:id], bus_data[:number], bus_data[:model]]
      }

      Bus.import(columns, data)
    end

    def import_bus_services
      id = 1
      services_command = "copy buses_services (id, bus_id, service_id) from stdin with csv delimiter ';'"
      connection = ActiveRecord::Base.connection.raw_connection

      ActiveRecord::Base.connection.raw_connection.copy_data services_command do
        @buses.each do |key, bus_data|
          bus_data[:services_ids].each do |servce_id|
            connection.put_copy_data("#{id};#{bus_data[:id]};#{servce_id}\n")

            id += 1
          end
        end
      end
    end
  end
end
