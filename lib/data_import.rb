# frozen_string_literal: true

class DataImport
  def initialize(file_name)
    @file_name = file_name
    @cities = {}
    @buses = {}
    @buses_services = {}
  end

  def start
    time = Benchmark.realtime do
      @cities = {}
      @buses = {}
      @buses_services = {}

      ActiveRecord::Base.transaction do
        connection = ActiveRecord::Base.connection.raw_connection
        trips_command = "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"
        connection.copy_data trips_command do
          File.open(@file_name) do |ff|
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
                  trip = Oj.load(str)
                  import_trip(trip, connection)
                  str = +""
                end
              when nesting >= 1
                str << ch
              end
            end
          end
        end

        services_command = "copy services (name) from stdin with csv delimiter ';'"
        connection.copy_data services_command do
          Service::SERVICES.each do |service|
            connection.put_copy_data("#{service}\n")
          end
        end

        cities_command = "copy cities (name) from stdin with csv delimiter ';'"
        connection.copy_data cities_command do
          @cities.keys.each do |city_name|
            connection.put_copy_data("#{city_name}\n")
          end
        end

        buses_command = "copy buses (model, number) from stdin with csv delimiter ';'"
        connection.copy_data buses_command do
          @buses.keys.each do |bus_key|
            connection.put_copy_data("#{bus_key}\n")
          end
        end

        buses_services_command = "copy buses_services (bus_id, service_id) from stdin with csv delimiter ';'"
        connection.copy_data buses_services_command do
          @buses_services.each do |bus_id, service_ids|
            service_ids.each do |service_id|
              connection.put_copy_data("#{bus_id};#{service_id}\n")
            end
          end
        end
      end
    end
    puts "Finish in #{time.round(2)}"
  end


  private


  def import_trip(trip, connection)
    from_id = @cities[trip['from']]
    if !from_id
      from_id = @cities.size + 1
      @cities[trip['from']] = from_id
    end

    to_id = @cities[trip['to']]
    if !to_id
      to_id = @cities.size + 1
      @cities[trip['to']] = to_id
    end

    bus = trip['bus']
    bus_key = "#{bus['model']};#{bus['number']}"
    bus_id = @buses[bus_key]
    if !bus_id
      bus_id = @buses.size + 1
      @buses[bus_key] = bus_id
    end
    service_ids = @buses_services[bus_id]
    if !service_ids
      @buses_services[bus_id] = []
      bus['services'].each do |service|
        service_id = Service::SERVICES.index(service) + 1
        @buses_services[bus_id] << service_id
      end
    end

    # стримим подготовленный чанк данных в postgres
    connection.put_copy_data("#{from_id};#{to_id};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus_id}\n")
  end
end