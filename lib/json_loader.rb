require 'benchmark'

class JsonLoader
  def initialize
    @cities = {}
    @buses = {}
    @services = {}
  end

  def perform(filename)
    time = Benchmark.realtime do
      load_from_file(filename)
    end

    puts "Finished in #{time.round(5)}"
  end

  private

  def load_from_file(filename)
    json = JSON.parse(File.read(filename))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      trips = []

      json.each do |trip|
        from = find_or_create_city(trip['from'])
        to = find_or_create_city(trip['to'])

        services = []
        trip['bus']['services'].each do |service|
          s = find_or_create_service(service)
          services << s
        end
        bus = find_or_create_bus(trip['bus']['number'], trip['bus']['model'], services)

        trips << Trip.new(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents']
        )
      end
      Trip.import(trips)
    end
  end

  def find_or_create_city(name)
    unless @cities[name]
      city = City.create(name: name)
      @cities[name] = city
    end

    @cities[name]
  end

  def find_or_create_service(name)
    unless @services[name]
      service = Service.create(name: name)
      @services[name] = service
    end

    @services[name]
  end

  def find_or_create_bus(number, model, services)
    unless @buses[number]
      bus = Bus.create(number: number, model: model, services: services)
      @buses[number] = bus
    end

    @buses[number]
  end
end
