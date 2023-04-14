require 'benchmark'

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  Benchmark.bm do |x|
    x.report { reload_json(args.file_name) }
  end

  # report = MemoryProfiler.report do
  #   reload_json(args.file_name)
  # end

  # report.pretty_print(scale_bytes: true)

  # result = RubyProf.profile do
  #   reload_json(args.file_name)
  # end

  # RubyProf.measure_mode = RubyProf::MEMORY

  # printer = RubyProf::FlatPrinter.new(result)
  # printer.print(File.open("./reports/memory_flat.txt", "w+"))

  # printer = RubyProf::GraphHtmlPrinter.new(result)
  # printer.print(File.open("./reports/memory_graph.html", "w+"))

  # printer = RubyProf::CallStackPrinter.new(result)
  # printer.print(File.open("./reports/memory_callstack.html", "w+"))

  # printer = RubyProf::CallTreePrinter.new(result)
  # printer.print(path: './reports/', profile: 'profile')
end

def reload_json(file_name)
  json = JSON.parse(File.read(file_name))

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    uniq_cities = {}
    uniq_buses = {}
    uniq_services = {}

    json.each do |trip|
      uniq_cities[trip['from']] ||= {name: trip['from']}
      uniq_cities[trip['to']] ||= {name: trip['to']}
      uniq_buses[trip['bus']['number']] ||= { number: trip['bus']['number'], model: trip['bus']['model'] }

      trip['bus']['services'].each do |service_name|
        uniq_services[service_name] = { name: service_name }
      end
    end

    City.upsert_all(uniq_cities.values, unique_by: :index_cities_on_name) if uniq_cities.present?
    Bus.upsert_all(uniq_buses.values, unique_by: :index_buses_on_number) if uniq_buses.present?
    Service.upsert_all(uniq_services.values, unique_by: :index_services_on_name) if uniq_services.present?

    cache = {
      cities: {},
      buses: {},
      services: {},
      bus_service_relations: []
    }

    cache[:cities] = Hash[City.pluck(:id, :name).map {|id, name| [name, id]}]
    cache[:buses] = Hash[Bus.pluck(:id, :number).map {|id, number| [number, id]}]
    cache[:services] = Hash[Service.pluck(:id, :name).map {|id, name| [name, id]}]

    trips = json.map do |trip|
      from_id = cache[:cities][trip['from']]
      to_id = cache[:cities][trip['to']]
      bus_id = cache[:buses][trip['bus']['number']]

      trip['bus']['services'].map do |service_name|
        cache[:bus_service_relations] << {
          service_id: cache[:services][service_name],
          bus_id: bus_id
        }
      end

      {
        from_id: from_id,
        to_id: to_id,
        bus_id: bus_id,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents'],
      }
    end

    BusesService.upsert_all(cache[:bus_service_relations], unique_by: :index_buses_services_on_bus_id_and_service_id) if cache[:bus_service_relations].present?
    Trip.insert_all(trips)
  end
end
