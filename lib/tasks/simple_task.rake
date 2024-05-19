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

        fetch_city = lambda do |name|
          return cities_hash[name] if cities_hash.key?(name)

          city = City.create(name: name)
          cities_hash[name] = city
          city
        end

        fetch_service_id = lambda do |service|
          #services_hash[service] ||= Service.find_or_create_by(name: service)

          return services_hash[service] if services_hash.key?(service)

          service_id = Service.create(name: service).id
          services_hash[service] = service_id
          service_id
        end

        json.each do |trip|
          from_city = fetch_city.call(trip['from'])
          to_city = fetch_city.call(trip['to'])

          service_ids = []
          trip['bus']['services'].each do |service|
            
            service_ids << fetch_service_id.call(service)
          end

          bus = Bus.find_or_create_by(number: trip['bus']['number'])
          bus.service_ids = service_ids
          #bus.update(model: trip['bus']['model'], services: services)


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
