# frozen_string_literal: true

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  start = Time.now

  json = JSON.parse(File.read(args.file_name))

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusesService.delete_all

    trips = []
    cities = {}
    buses = {}
    services = {}
    buses_services = []

    json.each do |trip|
      from = find_or_create_city(cities, trip['from'])
      to = find_or_create_city(cities, trip['to'])
      bus = find_or_create_bus(buses, trip['bus']['number'], trip['bus']['model'])

      trip['bus']['services'].each do |service|
        s = find_or_create_service(services, service)
        buses_services << { bus_id: bus.id, service_id: s.id }
      end

      trips << Trip.new(
        from: from,
        to: to,
        bus: bus,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents'],
      )

      if trips.size == 10000
        BusesService.import buses_services
        Trip.import trips
        trips = []
        buses_services = []
      end
    end

    BusesService.import buses_services
    Trip.import trips
  end

  finish = Time.now
  puts "Benchmark realtime: #{finish - start}"
end

def find_or_create_city(cities, city)
  cities[city] ||= City.find_or_create_by(name: city)
end

def find_or_create_bus(buses, number, model)
  buses[number] ||= Bus.find_or_create_by(number: number, model: model)
end

def find_or_create_service(services, service)
  services[service] ||= Service.find_or_create_by(name: service)
end
