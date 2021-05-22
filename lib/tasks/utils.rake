# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  json = JSON.parse(File.read(args.file_name))

  start = Time.now

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    trips = []
    cities = {}
    buses = {}
    services = {}
    bus_services_ids = []

    json.each do |trip|
      from = cities[trip['from']] ||= City.find_or_create_by(name: trip['from'])
      to = cities[trip['to']] ||= City.find_or_create_by(name: trip['to'])
      bus = buses[trip['bus']['number']] ||= Bus.find_or_create_by(number: trip['bus']['number'], model: trip['bus']['model'])

      trip['bus']['services'].each do |service|
        service = services[service] ||= Service.create!(name: service)
        bus_services_ids << { bus_id: bus.id, service_id: service.id }
      end

      trips << Trip.new(
        from: from,
        to: to,
        bus: bus,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents'],
      )
    end

    Trip.import trips
    BusService.import bus_services_ids
  end

  finish = Time.now
  puts finish - start
end
