# frozen_string_literal: true

class UtilsService
  TABLE_NAMES = %i[cities buses services trips buses_services].freeze

  def self.call(file_name)
    new.call(file_name)
  end

  def initialize
    @cities = {}
    @buses = Hash.new { |h, k| h[k] = {} }
    @services = Service::SERVICES.map.with_index(1).to_h
    @services_buses = @services.map { |_, index| [index, []] }.to_h
    @next_bus_id = 0
  end

  def call(file_name)
    ActiveRecord::Base.transaction do
      truncate
      copy_services
      copy_trips(file_name)
      copy_cities
      copy_buses
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
                fetch_city_id(trip[:from]).to_s << ';' <<
                fetch_city_id(trip[:to]).to_s << ';' <<
                trip[:start_time].to_s << ';' <<
                trip[:duration_minutes].to_s << ';' <<
                trip[:price_cents].to_s << ';' <<
                fetch_bus_id(trip[:bus]).to_s << "\n"
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

  def fetch_city_id(key)
    id = @cities[key]
    if !id
      id = @cities.size + 1
      @cities[key] = id
    end

    id
  end

  def fetch_bus_id(bus)
    bus_id = @buses[bus[:model]][bus[:number]]

    if !bus_id
      bus_id = @next_bus_id += 1
      @buses[bus[:model]][bus[:number]] = bus_id

      bus[:services].each do |service|
        @services_buses[@services[service]] << bus_id
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
        copy(id.to_s << ';' << name << "\n")
      end
    end
  end

  def copy_buses
    sql = <<~SQL
      copy buses (id, model, number) from stdin with csv delimiter ';'
    SQL

    ActiveRecord::Base.connection.raw_connection.copy_data(sql) do
      @buses.each do |model, numbers|
        numbers.each do |number, id|
          copy(id.to_s << ';' << model << ';' << number << "\n")
        end
      end
    end
  end

  def copy_services
    sql = <<~SQL
      copy services (id, name) from stdin with csv delimiter ';'
    SQL

    ActiveRecord::Base.connection.raw_connection.copy_data(sql) do
      @services.each do |name, id|
        copy(id.to_s << ';' << name << "\n")
      end
    end
  end

  def copy_buses_services
    sql = <<~SQL
      copy buses_services (bus_id, service_id) from stdin with csv delimiter ';'
    SQL

    ActiveRecord::Base.connection.raw_connection.copy_data(sql) do
      @services_buses.each do |service_id, bus_ids|
        bus_ids.each do |bus_id|
          copy(bus_id.to_s << ';' << service_id.to_s << "\n")
        end
      end
    end
  end

  def copy(values)
    # стримим подготовленный чанк данных в postgres
    ActiveRecord::Base.connection.raw_connection.put_copy_data(values)
  end
end
