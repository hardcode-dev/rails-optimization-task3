# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

task :reload_json, [:file_name] => [:environment] do |_task, args|
  json = Oj.load(File.read(args.file_name))
  ActiveRecord::Base.transaction do
    cities = []
    trips = []
    buses = []
    services = []
    buses_services = []

    # Select data for cities, buses and services
    json.each do |trip|
      cities << trip['from']
      cities << trip['to']

      trip_bus = trip['bus']

      trip_bus['services'].each do |service|
        services << service
      end

      buses << [trip_bus['number'], trip_bus['model']]
    end

    # Insert cities, buses and services
    ActiveRecord::Base.connection.execute('INSERT INTO cities ("name") VALUES ' << cities.uniq.map {|name| "('" << name << "')"}.join(',') )
    ActiveRecord::Base.connection.execute('INSERT INTO services ("name") VALUES ' << services.uniq.map {|name| "('" << name << "')"}.join(',') )
    ActiveRecord::Base.connection.execute('INSERT INTO buses ("number","model") VALUES ' << buses.uniq.map {|ar| "('" << ar.join("','") << "')" }.join(',') )

    services_a = Service.all
    cities_a = City.all
    buses_a = Bus.all
    # Select data for buses_services and trips
    json.each do |trip|
      from = cities_a.detect { |a| a.name == trip['from'] }
      to = cities_a.detect { |a| a.name == trip['to'] }

      trip_bus = trip['bus']

      bus = buses_a.detect{|b| b.number == trip_bus['number'] && b.model == trip_bus['model']}
      bus_id = bus.id.to_s

      trip_bus['services'].each do |service|
        bus_service_values = "('" << bus_id << "','" << services_a.detect { |a| a.name == service }.id.to_s << "')"
        buses_services << bus_service_values
      end

      trip = Trip.new(
        from: from,
        to: to,
        bus: bus,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents'],
      )
      trips << trip
    end

    # Insert buses_services and trips
    ActiveRecord::Base.connection.execute('INSERT INTO buses_services ("bus_id","service_id") VALUES ' << buses_services.uniq.join(',') )
    Trip.import(['from_id', 'to_id', 'bus_id', 'start_time', 'duration_minutes', 'price_cents'], trips)
  end
end
