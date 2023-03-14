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

    cache = {
      cities: {},
      services: {},
      buses: {}
    }

    json.each do |trip|
      from = cache[:cities][trip['from']] ||= City.find_or_create_by(name: trip['from'])
      to = cache[:cities][trip['to']] ||= City.find_or_create_by(name: trip['to'])
      services = []
      trip['bus']['services'].each do |service|
        s = cache[:services][service] ||= Service.find_or_create_by(name: service)
        services << s
      end
      bus = cache[:buses][trip['bus']['number']] ||= Bus.find_or_create_by(number: trip['bus']['number'])
      bus.update(model: trip['bus']['model'], services: services)

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
