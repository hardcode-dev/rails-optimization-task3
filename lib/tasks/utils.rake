# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  json = JSON.parse(File.read(args.file_name))

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    services = []
    Service::SERVICES.each do |service|
      services << Service.new(name: service)
    end
    Service.import services
    services = Service.all.inject({}) { |hash, el| hash[el.name] = el; hash; }

    cities = CiteService.new
    buses = BusService.new(services)
    json.each do |trip|
      cities.check_city(trip['from'])
      cities.check_city(trip['to'])
      buses.check_bus(trip['bus']['number'], model: trip['bus']['model'], service: trip['bus']['services'])
    end
    City.import cities.get_array
    Bus.import buses.get_array

    tripes = []
    json.each do |trip|
      from = cities.check_city(trip['from'])
      to = cities.check_city(trip['to'])
      bus = buses.check_bus(trip['bus']['number'])

      tripes << Trip.new(
                  from: from,
                  to: to,
                  bus: bus,
                  start_time: trip['start_time'],
                  duration_minutes: trip['duration_minutes'],
                  price_cents: trip['price_cents'],
                )
    end
    Trip.import tripes
  end
end
