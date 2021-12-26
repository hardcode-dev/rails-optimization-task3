# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  RubyProf.measure_mode = RubyProf::WALL_TIME
  RubyProf.start

  json = JSON.load(File.open(args.file_name))
  binding.pry

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    trips = json.map do |trip|
      from = City.find_or_create_by(name: trip['from'])
      to = City.find_or_create_by(name: trip['to'])

      services = trip['bus']['services'].map do |service|
        Service.find_or_create_by(name: service)
      end
      bus = Bus.find_or_create_by(number: trip['bus']['number'])
      bus.update(model: trip['bus']['model'], services: services)

      Trip.new(
        from: from,
        to: to,
        bus: bus,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents'],
      )
    end

    Trip.import trips
  end

  result = RubyProf.stop

  # printer = RubyProf::FlatPrinter.new(result)
  # printer.print(STDOUT, {})

  printer = RubyProf::GraphHtmlPrinter.new(result)
  printer.print(File.open('graph.html', 'w+'))

  printer = RubyProf::CallStackPrinter.new(result)
  printer.print(File.open('call_stack.html', 'w+'))
end
