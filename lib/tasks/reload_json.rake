# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  start_time = Time.now
  json = JSON.parse(File.read(args.file_name))
  end_time = Time.now
  p "JSON delta: #{end_time - start_time}"


  # Create services
  ActiveRecord::Base.transaction do
    service_data = Service::SERVICES.map { |service_name| Service.new(name: service_name) }
    Service.import service_data
  end

  bus_import_result = []
  cities = Set.new
  buses = Set.new
  trips = []
  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusesService.delete_all

    start_time = Time.now
    services = Service.all
    json.each do |json_record|
      cities << { name: json_record['from'] }
      cities << { name: json_record['to'] }
      bus_services_ids = services.select { |service| json_record['bus']['services'].include? service.name }.map(&:id)
      buses << { number: json_record['bus']['number'], model: json_record['bus']['model'], services: bus_services_ids}
    end
    end_time = Time.now
    p "New Partial delta: #{end_time - start_time}"

    start_time = Time.now
    cities_import_result = City.import cities.to_a
    bus_import_result = Bus.import buses.to_a.map { |bus| { number: bus[:number], model: bus[:model] } }
  end

  ActiveRecord::Base.transaction do
    Trip.import trips
  end

  buses_services_records = buses.to_a.each_with_index.flat_map { |bus, index| bus[:services].map { |service_id| { service_id: service_id, bus_id: bus_import_result.ids[index] } } }

  ActiveRecord::Base.transaction do
    BusesService.import buses_services_records
  end
    end_time = Time.now
    p "DB Import delta: #{end_time - start_time}"
end