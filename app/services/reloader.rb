# frozen_string_literal: true

class Reloader
  def self.reload(file_name)
    new(file_name).reload
  end

  def initialize(file_name)
    @file_name = file_name
  end

  def reload
    clear_db
    load_json
  end

  private

  def clear_db
    ActiveRecord::Base.connection
      .execute("TRUNCATE cities, buses, services, trips, buses_services RESTART IDENTITY CASCADE;")
  end

  def load_json
    @cities = {}
    @buses = {}
    @services = {}
    @buses_services = Set.new

    trips_command = "COPY trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) FROM STDIN WITH CSV DELIMITER ';'"

    connection.copy_data(trips_command) do
      File.open(@file_name, 'r') do |file|
        nesting = 0
        buffer = +""

        file.each_char do |ch|
          case ch
          when '{'
            nesting += 1
            buffer << ch
          when '}'
            nesting -= 1
            buffer << ch

            if nesting == 0
              trip = Oj.load(buffer)
              import_trip(trip)

              buffer = +""
            end
          else
            buffer << ch if nesting >= 1
          end
        end
      end
    end

    flush_cities
    flush_buses
    flush_services
    flush_buses_services
  end

  def import_trip(trip)
    from_id = find_or_create_city(trip['from'])
    to_id = find_or_create_city(trip['to'])
    bus_id = find_or_create_bus(trip['bus'])
    service_ids = trip['bus']['services'].map { |service| find_or_create_service(service) }

    connection.put_copy_data("#{from_id};#{to_id};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus_id}\n")

    service_ids.each do |service_id|
      @buses_services << [bus_id, service_id]
    end
  end

  def find_or_create_city(name)
    @cities[name] ||= @cities.size + 1
  end

  def find_or_create_bus(bus)
    bus_number = bus['number']
    model = bus['model']
    key = [model, bus_number]

    @buses[key] ||= @buses.size + 1
  end

  def find_or_create_service(name)
    @services[name] ||= @services.size + 1
  end

  def flush_cities
    return if @cities.empty?

    values = @cities.map { |name, id| "(#{id}, '#{name}')" }.join(', ')
    ActiveRecord::Base.connection.execute("INSERT INTO cities (id, name) VALUES #{values}")
  end

  def flush_buses
    return if @buses.empty?

    values = @buses.map do |(model, number), id|
      "(#{id}, '#{number}', '#{model}')"
    end.join(', ')
    ActiveRecord::Base.connection.execute("INSERT INTO buses (id, number, model) VALUES #{values}")
  end

  def flush_services
    return if @services.empty?

    values = @services.map { |name, id| "(#{id}, '#{name}')" }.join(', ')
    ActiveRecord::Base.connection.execute("INSERT INTO services (id, name) VALUES #{values}")
  end

  def flush_buses_services
    return if @buses_services.empty?

    values = @buses_services.map do |(bus_id, service_id)|
      "(#{bus_id}, #{service_id})"
    end.join(', ')

    ActiveRecord::Base.connection.execute("INSERT INTO buses_services (bus_id, service_id) VALUES #{values}")
  end

  def connection
    @connection ||= ActiveRecord::Base.connection.raw_connection
  end
end
