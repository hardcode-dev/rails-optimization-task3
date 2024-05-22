  # rake demo:reload_json[fixtures/small.json]
namespace :demo do
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
        buses_services = {}

        trips = []

        json.each do |trip|
          from = cities[trip['from']] ||= City.new(name: trip['from'])
          to = cities[trip['to']] ||= City.new(name: trip['to'])          

          bus = buses[trip['bus']['number']] ||= Bus.new(number: trip['bus']['number'], model: trip['bus']['model'])

          trip['bus']['services'].each do |service|
            bus_service = services[service] ||= Service.new(name: service)
            buses_services[[bus, bus_service]] ||= BusesService.new(bus: bus, service: bus_service)
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

        City.import cities.values
        Bus.import buses.values
        Service.import services.values
        BusesService.import buses_services.values
        Trip.import trips

        cities, services, buses, trips = nil
      end      
    end

    puts "Done in #{time.real} seconds"
    puts "MEMORY USAGE: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
  end
end
