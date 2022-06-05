# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  json = JSON.parse(File.read(args.file_name))
  uniq_cities = json.pluck('from', 'to').flatten.uniq.map! { |name| { name: name } }
  uniq_services = json.pluck('bus').pluck('services').flatten.uniq.map! { |name| { name: name } }
  uniq_buses = json.pluck('bus').map! { |b| { number: b['number'], model: b['model'] } }.uniq
  trips = []
  buses_services = []

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusesService.delete_all

    cities = City.insert_all!(uniq_cities, returning: [:id, :name])
    services = Service.insert_all!(uniq_services, returning: [:id, :name])
    buses = Bus.insert_all!(uniq_buses, returning: [:id, :number, :model])
    json.each do |trip|
      from_id = cities.to_a.detect { |city| city['name'] == trip['from'] }['id']
      to_id = cities.to_a.detect { |city| city['name'] == trip['to'] }['id']
      service_ids = services.to_a.select { |service| service['name'].in?(trip['bus']['services']) }.pluck('id')
      bus_id = buses.to_a.detect { |bus| bus['number'] == trip['bus']['number'] }['id']
      bus_services = service_ids.map { |id| { bus_id: bus_id, service_id: id } }
      buses_services << bus_services

      trip = {
        from_id: from_id,
        to_id: to_id,
        bus_id: bus_id,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
      trips << trip
    end

    buses_services.flatten!&.uniq!
    Trip.insert_all!(trips)
    BusesService.insert_all!(buses_services)
  end
end
