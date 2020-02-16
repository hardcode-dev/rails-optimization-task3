# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  start_time = Time.now
  json = JSON.parse(File.read(args.file_name))
  end_time = Time.now
  p "JSON delta: #{end_time - start_time}"

  start_time = Time.now
  ActiveRecord::Base.transaction do
    # Clean previous state
    City.delete_all
    Bus.delete_all
    Trip.delete_all
    Service.delete_all
    BusesService.delete_all

    # Create services
    service_data = Service::SERVICES.map { |service_name| Service.new(name: service_name) }
    Service.import service_data
    services = Service.all

    cities = Set.new
    buses = Set.new
    trips = []

    # Get info form json about cities, buses and bus services
    json.each do |json_record|
      cities << { name: json_record['from'] }
      cities << { name: json_record['to'] }
      bus_services_ids = services.select do |service|
        json_record['bus']['services'].include? service.name
      end.map(&:id)
      buses << { number: json_record['bus']['number'],
                 model: json_record['bus']['model'],
                 services: bus_services_ids }
    end

    # Import cities and buses to DB
    cities_import = City.import cities.to_a
    bus_import = Bus.import buses.to_a.map { |bus| { number: bus[:number], model: bus[:model] } }

    # Prepare rows for BusesServices table (services -> buses association)
    buses_services_records = buses.to_a.each_with_index.flat_map do |bus, index|
      bus[:services].map { |service_id| { service_id: service_id, bus_id: bus_import.ids[index] } }
    end
    # Import rows to buses_services table (services -> buses association)
    BusesService.import buses_services_records

    # Prepare import results and data collections for Trip import
    imported_cities = cities.to_a.each_with_index.map do |city, index|
      { name: city[:name],
        id: cities_import.ids[index] }
    end

    imported_buses = buses.to_a.each_with_index.map do |bus, index|
      { number: bus[:number],
        id: bus_import.ids[index] }
    end

    # Prepare trips collection for DB import
    json.each do |json_record|
      bus_id = imported_buses.find do |bus_record|
        bus_record[:number] == json_record['bus']['number']
      end[:id]
      from_id = imported_cities.find do |city_record|
        city_record[:name] == json_record['from']
      end[:id]
      to_id = imported_cities.find do |city_record|
        city_record[:name] == json_record['to']
      end[:id]

      trips << { start_time: json_record['start_time'],
                 duration_minutes: json_record['duration_minutes'],
                 price_cents: json_record['price_cents'],
                 bus_id: bus_id,
                 from_id: from_id,
                 to_id: to_id }
    end

    # Import trips to the DB
    Trip.import trips
  end
  end_time = Time.now
  p "AR transaction delta: #{end_time - start_time}"
end