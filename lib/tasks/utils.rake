# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  start_time = Time.current
  puts "Start at #{start_time}"
  json = JSON.parse(File.read(args.file_name))
  puts "Parsed at #{Time.current}"

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    cities = {}
    all_services = {}
    buses = {}
    trips = []

    json.each do |trip|
       # NOTE! можно хранить только id
      cities[trip['from']] ||= City.create(name: trip['from'])
      from = cities[trip['from']]

      cities[trip['to']] ||= City.create(name: trip['to'])
      to = cities[trip['to']]

      services = []
      trip['bus']['services'].each do |service|
        all_services[service] ||= Service.create(name: service)
        services << all_services[service]
      end

      buses[trip['bus']['number']] ||= Bus.create(number: trip['bus']['number']) do |b|
        b.model = trip['bus']['model']
        b.services = services
      end
      bus = buses[trip['bus']['number']]

      trips << {
        from_id: from.id,
        to_id: to.id,
        bus_id: bus.id,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
    end

    Trip.upsert_all(trips)
  end
  end_time = Time.current
  puts "End at #{end_time}"
  puts "Таска выполнена за #{end_time - start_time} секунд"
end
