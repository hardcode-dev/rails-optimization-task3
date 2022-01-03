# Наивная загрузка данных из json-файла в БД
# rake reload_json\[fixtures/small.json\]
task :reload_json, [:file_name] => :environment do |_task, args|
  def add_to_hash(hash, key)
    hash[key] ||= { id: hash.size + 1, name: key }
  end

  # RubyProf.measure_mode = RubyProf::WALL_TIME
  # RubyProf.start

  starts_at = Time.current

  json = JSON.load(File.open(args.file_name))

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.destroy_all
    Service.destroy_all
    BusService.delete_all
    Trip.delete_all

    cities = {}
    services = {}
    buses = {}
    buses_services = []

    trips = json.map do |trip|
      add_to_hash(cities, trip['from'])
      add_to_hash(cities, trip['to'])

      trip['bus']['services'].each do |service_name|
        add_to_hash(services, service_name)
      end

      services_ids = services.select { |service_name, _data| trip['bus']['services'].include?(service_name) }
                             .values.map { |service| service[:id] }
      bus = {
        id: buses.size + 1,
        number: trip['bus']['number'],
        model: trip['bus']['model']
      }
      buses_services_values = services_ids.map do |service_id|
        { service_id: service_id, bus_id: buses.size + 1 }
      end

      if buses[trip['bus']['number']].nil?
        buses_services << buses_services_values
        buses[trip['bus']['number']] = bus
      end

      {
        from_id: cities[trip['from']][:id],
        to_id: cities[trip['to']][:id],
        bus_id: buses[trip['bus']['number']][:id],
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
    end

    City.import cities.values, validate: false
    Service.import services.values
    Bus.import buses.values, validate: false
    Trip.import trips, validate: false
    BusService.import buses_services.flatten, validate: false
  end

  ends_at = Time.current
  puts "Time spent: #{ends_at.to_i - starts_at.to_i} sec."

  # result = RubyProf.stop
  #
  # printer = RubyProf::FlatPrinter.new(result)
  # printer.print(STDOUT, {})
  #
  # printer = RubyProf::GraphHtmlPrinter.new(result)
  # printer.print(File.open('graph.html', 'w+'))
  #
  # printer = RubyProf::CallStackPrinter.new(result)
  # printer.print(File.open('call_stack.html', 'w+'))
end
