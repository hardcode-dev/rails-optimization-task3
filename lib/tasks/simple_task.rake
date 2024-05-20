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

        cities = {}
        services = {}
        buses = {}

        json.each do |trip|
          from = cities[trip['from']] ||= City.create(name: trip['from'])
          to = cities[trip['to']] ||= City.create(name: trip['to'])

          bus_services = trip['bus']['services'].map! { |s| services[s] ||= Service.create(name: s) }

          bus = buses[trip['bus']['number']] ||= Bus.create(number: trip['bus']['number'], model: trip['bus']['model'], services: bus_services)

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

    puts "Done in #{time.real} seconds"
  end
end
