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

    json.each do |trip|
      from = City.find_or_create_by(name: trip['from'])
      to = City.find_or_create_by(name: trip['to'])
      services = []
      trip['bus']['services'].each do |service|
        s = Service.find_or_create_by(name: service)
        services << s
      end
      bus = Bus.find_or_create_by(number: trip['bus']['number'])
      bus.update(model: trip['bus']['model'], services: services)

      Trip.create!(
        from: from,
        to: to,
        bus: bus,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents'],
      )
    end
  end
end

task :reload_json_new, [:file_name] => :environment do |task, args|
  time = Benchmark.realtime do

    json = JSON.parse(File.read(args.file_name))

    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    services_all = {}
    cities = {}
    buses = {}
    trips = []
    json.each do |trip|
      if buses[trip['bus']['number']].nil?
        services = []
        trip['bus']['services'].each do |service|
          s = if services_all[service].nil?
                Service.find_or_create_by(name: service)
              else
                services_all[service]
              end
          services << s
          services_all[service] = s
        end
        bus = Bus.find_or_create_by(number: trip['bus']['number'])
        bus.update(model: trip['bus']['model'], services: services)
        buses[trip['bus']['number']] = bus
      end

      from = if cities[trip['from']].nil?
               city = City.find_or_create_by(name: trip['from'])
               cities[trip['from']] = city
             else
               cities[trip['from']]
             end
      to = if cities[trip['to']].nil?
             city = City.find_or_create_by(name: trip['to'])
             cities[trip['to']] = city
           else
             cities[trip['to']]
           end

      trp = Trip.new(
        from: from,
        to: to,
        bus: buses[trip['bus']['number']],
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      )
      trips << trp

    end
    Trip.import trips, validate: false
  end

  puts "Finish in #{time} seconds/"
end