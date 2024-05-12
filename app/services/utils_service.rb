# frozen_string_literal: true

class UtilsService
  TABLE_NAMES = %i[cities buses services trips buses_services].freeze

  def self.call(file_name)
    new.call(file_name)
  end

  def initialize
    @cities = {}
    @buses = {}
    @buses_services = {}
    @services = {}
  end

  def call(file_name)
    ActiveRecord::Base.transaction do
      truncate
      copy_trips(file_name)
      copy_cities
      copy_buses
      copy_services
      copy_buses_services
    end
  end

  def truncate
    TABLE_NAMES.each do |table_name|
      sql = <<~SQL
        TRUNCATE #{table_name} RESTART IDENTITY;
      SQL

      ActiveRecord::Base.connection.execute(sql)
    end
  end

  def copy_trips(file_name)
    sql = <<~SQL
      copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'
    SQL

    ActiveRecord::Base.connection.raw_connection.copy_data(sql) do
      File.open(file_name) do |ff|
        nesting = 0
        str = +""

        while !ff.eof?
          ch = ff.read(1) # читаем по одному символу
          case
          when ch == '{' # начинается объект, повышается вложенность
            nesting += 1
            str << ch
          when ch == '}' # заканчивается объект, понижается вложенность
            nesting -= 1
            str << ch

            if nesting == 0 # если закончился объкет уровня trip, парсим и импортируем его
              trip = FastJsonparser.parse(str)

              copy(
                fetch_city_id(trip, :from),
                fetch_city_id(trip, :to),
                trip[:start_time],
                trip[:duration_minutes],
                trip[:price_cents],
                fetch_bus_id(trip[:bus])
              )

              str.clear
            end
          when nesting >= 1
            str << ch
          end
        end
      end
    end
  end

  def fetch_city_id(trip, key)
    id = @cities[trip[key]]
    if !id
      id = @cities.size + 1
      @cities[trip[key]] = id
    end

    id
  end

  def fetch_bus_id(bus)
    bus_key = [bus[:model], bus[:number]]
    bus_id = @buses[bus_key]

    if !bus_id
      bus_id = @buses.size + 1
      @buses[bus_key] = bus_id

      bus[:services].each do |service|
        service_id = @services[service]

        if !service_id
          service_id = @services.size + 1
          @services[service] ||= service_id
        end

        buses_service_id = @buses_services[[bus_id, service_id]]
        if !buses_service_id
          buses_service_id = @buses_services.size + 1
          @buses_services[[bus_id, service_id]] = buses_service_id
        end
      end
    end

    bus_id
  end

  def copy_cities
    sql = <<~SQL
      copy cities (id, name) from stdin with csv delimiter ';'
    SQL

    ActiveRecord::Base.connection.raw_connection.copy_data(sql) do
      @cities.each do |name, id|
        copy(id, name)
      end
    end

    @cities.clear
  end

  def copy_buses
    sql = <<~SQL
      copy buses (id, model, number) from stdin with csv delimiter ';'
    SQL

    ActiveRecord::Base.connection.raw_connection.copy_data(sql) do
      @buses.each do |(model, number), id|
        copy(id, model, number)
      end
    end

    @buses.clear
  end

  def copy_services
    sql = <<~SQL
      copy services (id, name) from stdin with csv delimiter ';'
    SQL

    ActiveRecord::Base.connection.raw_connection.copy_data(sql) do
      @services.each do |name, id|
        copy(id, name)
      end
    end

    @services.clear
  end

  def copy_buses_services
    sql = <<~SQL
      copy buses_services (id, bus_id, service_id) from stdin with csv delimiter ';'
    SQL

    ActiveRecord::Base.connection.raw_connection.copy_data(sql) do
      @buses_services.each do |(bus_id, service_id), id|
        copy(id, bus_id, service_id)
      end
    end

    @buses_services.clear
  end

  def copy(*values)
    # стримим подготовленный чанк данных в postgres
    ActiveRecord::Base.connection.raw_connection.put_copy_data(values.join(';') << "\n")
  end
end
