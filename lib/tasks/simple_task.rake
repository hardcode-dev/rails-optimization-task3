namespace :demo do
  # Наивная загрузка данных из json-файла в БД  
  # rake reload_json[fixtures/small.json]
  task :reload_json, [:file_name] => :environment do |_task, args|

    time = Benchmark.measure do
      json = JSON.parse(File.read(args.file_name))

      ActiveRecord::Base.transaction do
        City.delete_all
        Bus.delete_all
        Service.delete_all
        Trip.delete_all
        ActiveRecord::Base.connection.execute('delete from buses_services;')

        cities_hash = {}
        services_hash = {}
        buses_hash = {}

        fetch_city = lambda do |name|
          return cities_hash[name] if cities_hash.key?(name)

          city = City.create(name: name)
          cities_hash[name] = city
          city
        end

        fetch_service_id = lambda do |service|
          return services_hash[service] if services_hash.key?(service)

          service_id = Service.create(name: service).id
          services_hash[service] = service_id
          service_id
        end

        fetch_bus = lambda do |number, model, bus_services|
          return buses_hash["#{number}-#{model}"] if buses_hash.key?("#{number}-#{model}")

          service_ids = bus_services.map! { |service| fetch_service_id.call(service) }
          bus = Bus.create(number: number, model: model)
          bus.service_ids = service_ids
          buses_hash["#{number}-#{model}"] = bus
          bus
        end

        json.each do |trip|
          from_city = fetch_city.call(trip['from'])
          to_city = fetch_city.call(trip['to'])

          bus = fetch_bus.call(trip['bus']['number'], trip['bus']['model'], trip['bus']['services'])

          Trip.create!(
            from: from_city,
            to: to_city,
            bus: bus,
            start_time: trip['start_time'],
            duration_minutes: trip['duration_minutes'],
            price_cents: trip['price_cents'],
          )
        end
        
      end      

    end

    puts "Done in #{time.real} seconds"
  end
end
