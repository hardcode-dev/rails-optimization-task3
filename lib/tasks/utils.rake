# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  # ActiveRecord::Base.logger = Logger.new(STDOUT)
  fails = []
  json = JSON.parse(File.read(args.file_name))

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusesServices.delete_all

    cities = Set.new
    buses = Set.new
    trips = Set.new
    buses_services = Set.new

    services = Service::SERVICES.map { |name| Service.new(name: name) }

    json.each do |trip|
      cities << { name: trip['from'] }
      cities << { name: trip['to'] }
      buses << { number: trip['bus']['number'], model: trip['bus']['model'] }
    end

    fails += Service.import(services).failed_instances
    fails += City.import(cities.to_a).failed_instances
    fails += Bus.import(buses.to_a).failed_instances

    city_id_by_name = City.all.map { |city| [city.name, city.id] }.to_h
    bus_id_by_number = Bus.all.map { |bus| [bus.number, bus.id] }.to_h
    service_id_by_name = Service.all.map { |ser| [ser.name, ser.id] }.to_h

    json.each do |trip|
      bus_id = bus_id_by_number[trip['bus']['number']]
      trip['bus']['services'].each do |service|
        service_id = service_id_by_name[service]
        buses_services << { bus_id: bus_id, service_id: service_id }
      end

      trips << {
        from_id: city_id_by_name[trip['from']],
        to_id: city_id_by_name[trip['to']],
        bus_id: bus_id_by_number[trip['bus']['number']],
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
    end

    fails += Trip.import(trips.to_a).failed_instances
    fails += BusesServices.import(buses_services.to_a).failed_instances
    if fails.any?
      puts "Failed instances: #{fails}"
    else
      puts 'Everything is fine.'
    end
  end
end
