class Importer

  def self.profile(file_name = 'fixtures/small.json')

    require 'ruby-prof'

    GC.disable
    result = RubyProf.profile do
      self.new.import(file_name)
    end
    GC.enable

    printer = RubyProf::FlatPrinter.new(result)
    printer.print(File.open('flat.txt', 'w+'), :min_percent => 2)
    printer = RubyProf::DotPrinter.new(result)
    printer.print(File.open('graphviz.dot', 'w+'), :min_percent => 2)
    printer = RubyProf::GraphHtmlPrinter.new(result)
    printer.print(File.open('graph.html', 'w+'), :min_percent => 2)
    printer = RubyProf::CallStackPrinter.new(result)
    printer.print(File.open('callstack.html', 'w+'), :min_percent => 2)
  end


  def city_by_name(name)
    cached = @cities[name]

    return cached if cached

    city = City.find_or_create_by!(name: name)

    @cities[name] = city
  end


  def service_by_name(name)
    cached = @services[name]

    return cached if cached

    service = Service.find_or_create_by!(name: name)

    @services[name] = service
  end

  def cleanup
    @cities = {}
    @services = {}

    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

  end


  def import(file_name)
    json = JSON.parse(File.read(file_name))


    puts Time.now.to_f
    ActiveRecord::Base.transaction do


      cleanup

      json.each do |trip|
        from = city_by_name(trip['from'])
        to = city_by_name(trip['to'])

        services = trip['bus']['services'].collect(&method(:service_by_name))

        bus = Bus.find_or_create_by(number: trip['bus']['number'])
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
    puts Time.now.to_f
  end
end