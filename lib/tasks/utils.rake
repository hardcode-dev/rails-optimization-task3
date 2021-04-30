# frozen_string_literal: true

# rake reload_json_online[fixtures/10М.json]
task :reload_json_oneline, [:file_name] => :environment do |_task, args|
  def instant_create(klass, attrs)
    object = klass.new(attrs)
    object.save(validate: false)
    object.id
  end

  def parse(line, ix)
    if ix == 0
      line.slice!(0)
    else
      line.prepend('{')
      line.delete_suffix!(']')
    end
    line.delete_suffix!(',{')

    Oj.load(line)
  end

  def with_copy(table, *columns)
    connection = ActiveRecord::Base.connection_pool.checkout.raw_connection
    connection.copy_data "COPY #{table} (#{columns.join(',')}) FROM STDIN WITH CSV DELIMITER ';'" do
      yield connection
    end
  end

  def do_copy(connection, *data)
    connection.put_copy_data(data.map(&:to_s).join(';') << "\n")
  end

  City.delete_all
  Bus.delete_all
  Service.delete_all
  Trip.delete_all
  ActiveRecord::Base.connection.execute('DELETE FROM buses_services;')

  cities = {}
  services = {}
  buses = {}

  with_copy :buses_services,
            'bus_id', 'service_id' do |buses_services_connection|
    with_copy :trips,
              'from_id', 'to_id', 'start_time',
              'duration_minutes', 'price_cents', 'bus_id' do |trips_connection|
      pb = ProgressBar.new(1_000_000)

      File.open("fixtures/10M.json").each("},{").with_index do |line, ix|
        trip = parse(line, ix)

        city_from_id, city_to_id = %w[from to].map do |key|
          cities[trip[key]] ||= instant_create(City, name: trip[key])
        end

        bus_h = trip['bus']
        bus_id = buses[bus_h['number']]
        if bus_id.nil?
          bus_id = instant_create(Bus, number: bus_h['number'], model: bus_h['model'])
          buses[bus_h['number']] = bus_id

          bus_h['services'].each do |service_name|
            services[service_name] ||= instant_create(Service, name: service_name)

            do_copy buses_services_connection, bus_id, services[service_name]
          end
        end

        do_copy trips_connection,
                city_from_id, city_to_id,
                trip['start_time'], trip['duration_minutes'], trip['price_cents'],
                bus_id

        pb.increment!
      end
    end
  end

  puts "MEMORY USAGE: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
end

# rake reload_json[fixtures/large.json]
task :reload_json, [:file_name] => :environment do |_task, args|
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
  puts "MEMORY USAGE: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
end
