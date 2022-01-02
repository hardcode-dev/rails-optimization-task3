# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  def add_to_hash(hash, key)
    return if hash[key].present?

    hash[key] = { id: hash.size + 1, name: key }
  end

  # RubyProf.measure_mode = RubyProf::WALL_TIME
  # RubyProf.start

  json = JSON.load(File.open(args.file_name))

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.destroy_all
    Service.destroy_all
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

      buses_services << buses_services_values
      buses[trip['bus']['number']] = bus if buses[trip['bus']['number']].nil?

      {
        from_id: cities[trip['from']][:id],
        to_id: cities[trip['to']][:id],
        bus_id: bus[:id],
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
    end

    City.import cities.values
    Service.import services.values
    Bus.import buses.values
    Trip.import trips

    bs_data = buses_services.flatten.map { |bs| "(#{bs[:bus_id]},#{bs[:service_id]})" }.join(',')
    ActiveRecord::Base.connection.execute("INSERT INTO buses_services (bus_id, service_id) VALUES #{bs_data}")
  end

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
