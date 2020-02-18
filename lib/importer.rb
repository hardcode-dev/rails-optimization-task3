class Importer



  def self.profile2(file_name = 'fixtures/medium.json')

    GC.disable
    Rails.logger.level = 5

    StackProf.run(mode: :cpu, out: 'tmp/stackprof-cpu-myapp.dump', raw: true) do
      self.new.import(file_name)
    end
    GC.enable

  end


  def self.profile(file_name = 'fixtures/medium.json')

    require 'ruby-prof'

    GC.disable
    result = RubyProf.profile do
      self.new.import(file_name)
    end
    GC.enable

    printer = RubyProf::FlatPrinter.new(result)
    printer.print(File.open('flat.txt', 'w+'))
    printer = RubyProf::DotPrinter.new(result)
    printer.print(File.open('graphviz.dot', 'w+'), :min_percent => 10)
    printer = RubyProf::GraphHtmlPrinter.new(result)
    printer.print(File.open('graph.html', 'w+'), :min_percent => 10)
    # printer = RubyProf::CallStackPrinter.new(result)
    # printer.print(File.open('callstack.html', 'w+'), :min_percent => 2)
  end


  def city_by_name(name)
    @cities[name] ||= City.create!(name: name)
  end

  def service_by_name(name)
    @services[name] ||= Service.create!(name: name)
  end

  def bus_id_by_number(number, model, service_names)
    @busses[number] ||= Bus.create!(number: number,
                                    model: model,
                                    services: service_names.collect(&method(:service_by_name))
    ).id
  end


  def cleanup
    @cities = {}
    @services = {}
    @busses = {}

    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

  end

  TRIPS_BATCH_SIZE = 100

  def import(file_name)

    json = JSON.parse(File.read(file_name))



    trips = []


    ActiveRecord::Base.transaction do


      cleanup

      json.reverse_each do |trip|
        from = city_by_name(trip['from'])
        to = city_by_name(trip['to'])

        bus_id = bus_id_by_number(trip['bus']['number'], trip['bus']['model'], trip['bus']['services'])


        trips << Trip.new(
            from: from,
            to: to,
            bus_id: bus_id,
            start_time: trip['start_time'],
            duration_minutes: trip['duration_minutes'],
            price_cents: trip['price_cents'],
        )


        if trips.count > TRIPS_BATCH_SIZE
          Trip.import trips
          trips = []
        end


      end


      Trip.import trips

    end
  end
end