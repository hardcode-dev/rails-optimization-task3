# encoding: utf-8
# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
require "oj"
task :reload_json, [:file_name] => :environment do |_task, args|
  desc "загрузка данных из json-файла в БД"
  starting = Time.now
  puts "Start parsing"
  json = Oj.load(File.read(args.file_name), :symbol_keys => true)

  trips = []
  buses = {}
  services = {}
  cities = {}
  buses_services = {}

  def city(cities, name)
    result = cities[name]
    if result.nil?
      result = City.new(name: name)
      cities[name] = result
    end
    result
  end

  def service(services, name)
    result = services[name]
    if result.nil?
      result = Service.new(name: name)
      services[name] = result
    end
    result
  end

  def bus_service(buses_services, bus, service)
    result = BusesService.new(bus: bus, service: service)
    buses_services[bus] ||= {}
    buses_services[bus][service] = result
  end

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute("delete from buses_services;")

    json.each do |trip|
      from = city(cities, trip[:from])
      to = city(cities, trip[:to])

      bus = buses[trip[:bus][:number]]
      if bus.nil?
        bus = Bus.new(number: trip[:bus][:number])
        bus.model = trip[:bus][:model]

        trip[:bus][:services].each do |service|
          service_item = service(services, service)
          bus_service(buses_services, bus, service_item)
        end
        buses[trip[:bus][:number]] = bus
      end

      trips << Trip.new(
        from: from,
        to: to,
        bus: bus,
        start_time: trip[:start_time],
        duration_minutes: trip[:duration_minutes],
        price_cents: trip[:price_cents],
      )
    end

    City.import cities.values
    Service.import services.values
    Bus.import buses.values
    BusesService.import buses_services.values.map(&:values).flatten
    Trip.import trips
  end

  ending = Time.now
  puts "End parsing in #{(ending - starting)} sec"
end
