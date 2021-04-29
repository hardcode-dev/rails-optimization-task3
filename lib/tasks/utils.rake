# frozen_string_literal: true

# rake reload_json[fixtures/large.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  at_exit do
    puts "MEMORY USAGE: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
  end

  benchmark = Benchmark.bm(20) do |bm|
    json = JSON.parse(File.read(args.file_name))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      trips = []
      cities = {}
      services = {}
      buses = {}
      bus_services = []

      bm.report('Load and import Services and Cities') do
        pb = ProgressBar.new(json.length)
        json.each do |trip|
          from = cities[trip['from']] ||= City.create!(name: trip['from'].tr(' ', '-'))
          to = cities[trip['to']] ||= City.create!(name: trip['to'].tr(' ', '-'))

          bus_h = trip['bus']
          bus = buses[bus_h['number']]
          if bus.nil?
            bus = Bus.new(number: bus_h['number'], model: bus_h['model'])
            buses[bus_h['number']] = bus

            bus_services.push(bus_h['services'].map do |service_name|
              services[service_name] ||= Service.create!(name: service_name)
              services[service_name].id
            end)
          end

          trips << Trip.new(
            from: from,
            to: to,
            bus: bus,
            start_time: trip['start_time'],
            duration_minutes: trip['duration_minutes'],
            price_cents: trip['price_cents'],
          )

          pb.increment!
        end
      end

      bus_ids = nil
      bm.report('Import Buses') do
        bus_ids = Bus.import(buses.values).ids
      end

      bm.report('Import Bus Services') do
        bus_services_ids = []
        bus_ids.each do |bus_id|
          service_ids = bus_services.shift
          service_ids.each do |service_id|
            bus_services_ids.push [bus_id, service_id]
          end
        end
        BusesService.import [:bus_id, :service_id], bus_services_ids
      end

      bm.report('Import Trips') do
        Trip.import trips
      end
    end
  end
  puts

  puts "Imported: "
  puts " - Cities: #{City.count}"
  puts " - Services: #{Service.count}"
  puts " - Buses: #{Bus.count}"
  puts " - BusesServices: #{BusesService.count}"
  puts " - Trips: #{Trip.count}"
  puts

  puts "Benchmark:"
  puts " - #{benchmark.sum}"
  puts
end
