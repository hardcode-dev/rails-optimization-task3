# frozen_string_literal: true

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

require 'benchmark'

@cities = {}
@services = {}
@buses = {}

def import_trip(trip)
  from_id = @cities[trip['from']]
  unless from_id
    from_id = @cities.size + 1
    @cities[trip['from']] = from_id
  end

  to_id = @cities[trip['to']]
  unless to_id
    to_id = @cities.size + 1
    @cities[trip['to']] = to_id
  end

  trip['bus']['services'].each do |service|
    service_id = @services[service]
    unless service_id
      service_id = @services.size + 1
      @services[service] = service_id
    end
  end

  bus_id = @buses[trip['bus']['number']].try(:[], :id)
  unless bus_id
    bus_id = @buses.size + 1
    services = trip['bus']['services'].map do |s|
      @services[s]
    end
    @buses[trip['bus']['number']] = { id: bus_id, model: trip['bus']['model'], services: services }
  end

  bus_id = @buses[trip['bus']['number']][:id]
  ActiveRecord::Base.connection.raw_connection.put_copy_data("#{@cities[trip['from']]};#{@cities[trip['to']]};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus_id}\n")
end

task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.realtime do
    ActiveRecord::Base.transaction do
      trips_command = "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"

      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')
      ActiveRecord::Base.connection.reset_pk_sequence!('cities')
      ActiveRecord::Base.connection.reset_pk_sequence!('buses')
      ActiveRecord::Base.connection.reset_pk_sequence!('services')

      ActiveRecord::Base.connection.raw_connection.copy_data trips_command do
        File.open(args.file_name) do |ff|
          nesting = 0
          str = +''

          until ff.eof?
            ch = ff.read(1) # читаем по одному символу
            if ch == '{' # начинается объект, повышается вложенность
              nesting += 1
              str << ch
            elsif ch == '}' # заканчивается объект, понижается вложенность
              nesting -= 1
              str << ch
              if nesting == 0 # если закончился объкет уровня trip, парсим и импортируем его
                trip = Oj.load(str)

                import_trip(trip)

                str = +''
              end
            elsif nesting >= 1
              str << ch
            end
          end
        end
      end

      cities = []
      @cities.each do |city|
        cities << City.new(name: city[0])
      end

      buses = []
      buses_services = []
      @buses.each do |value|
        buses << Bus.new(number: value[0], model: value[1][:model])
        value[1][:services].map do |s|
          buses_services << BusesService.new(bus_id: value[1][:id], service_id: s)
        end
      end

      services = []
      @services.each do |value|
        services << Service.new(name: value[0])
      end

      City.import cities
      Service.import services
      Bus.import buses
      BusesService.import buses_services
    end
  end

  puts "Finish in #{time.round(2)}"
end
