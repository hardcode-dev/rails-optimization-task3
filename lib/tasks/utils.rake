desc 'Import data from json file'
task :optim_reload_json, [:file_name] => :environment do |_task, args|
  start_time = Time.now

  [City, Bus, Service, Trip, Buses::Service].each do |model|
    ActiveRecord::Base.connection.execute("TRUNCATE #{model.table_name} RESTART IDENTITY")
  end

  puts "Cleared tables #{Time.now - start_time} sec"
  increment = 0
  model_servicies_size = Service::SERVICES.size

  cities = []
  db_cities = []

  servicies = []
  db_servicies = []

  buses = []
  db_buses = []
  db_buses_services = []

  db_trips = []

  File.open(args.file_name) do |ff|
    nesting = 0
    str = +""

    while !ff.eof?
      ch = ff.read(1) # читаем по одному символу
      case
      when ch == '{' # начинается объект, повышается вложенность
        nesting += 1
        str << ch
      when ch == '}' # заканчивается объект, понижается вложенность
        nesting -= 1
        str << ch
        if nesting == 0 # если закончился объкет уровня trip, парсим и импортируем его
          trip = Oj.load(str)
          # my_import(trip)
          # puts trip
          # ImportService.new(trip).call

          # import cities
          from = trip['from']

          if cities.index(from).nil?
            cities << from

            db_cities << City.new(
              id: cities.index(from) + 1,
              name: from
            )
          end

          to = trip['to']

          if cities.index(to).nil?
            cities << to

            db_cities << City.new(
              id: cities.index(to) + 1,
              name: to
            )
          end
          # end import cities

          # import buses & db_buses_services
          bus_number = trip['bus']['number']

          if buses.index(bus_number).nil?
            buses << bus_number

            db_buses << Bus.new(
              id: buses.index(bus_number) + 1,
              number: bus_number,
              model: trip['bus']['model']
            )

            trip['bus']['services'].each do |service|
              if servicies.size < model_servicies_size && servicies.index(service).nil?
                servicies << service

                db_servicies << Service.new(
                  id: servicies.index(service) + 1,
                  name: service
                )
              end

              db_buses_services << Buses::Service.new(
                bus_id: buses.index(bus_number) + 1,
                service_id: servicies.index(service) + 1
              )
            end
          end
          # end import buses

          # import trips
          db_trips << Trip.new(
            bus_id: buses.index(bus_number) + 1,
            from_id: cities.index(from) + 1,
            to_id: cities.index(to) + 1,
            start_time: trip['start_time'],
            duration_minutes: trip['duration_minutes'],
            price_cents: trip['price_cents'],
          )
          # end import trips

          increment += 1
          str = +""
        end
      when nesting >= 1
        str << ch
      end
    end
  end
  City.import db_cities
  Service.import db_servicies
  Bus.import db_buses
  Buses::Service.import db_buses_services
  Trip.import db_trips

  puts "#{increment} records"
  puts "#{Time.now - start_time} sec"
end

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  start_time = Time.now
  increment = 0
  json = JSON.parse(File.read(args.file_name))

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    json.each do |trip|
      increment += 1
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
  puts "#{increment} records"
  puts "#{Time.now - start_time} sec"
end
