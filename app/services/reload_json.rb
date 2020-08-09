class ReloadJson
  class << self
    def call(file_name)
      new.call(file_name)
    end
  end

  attr_reader :cities, :services, :buses, :trips

  def initialize
    @cities = {}
    @services = {}
    @buses = {}
    @trips = []
  end

  def call(file_name)
    json = Oj.load(File.read(file_name))

    ActiveRecord::Base.transaction do
      Trip.delete_all
      City.delete_all
      BusesService.delete_all
      Bus.delete_all
      Service.delete_all

      json.each do |trip|
        from = find_or_create_city(trip['from'])
        to = find_or_create_city(trip['to'])

        bus_services = []

        trip['bus']['services'].each do |service|
          bus_services << find_or_create_service(service)
        end

        bus = find_or_create_bus(
          trip['bus']['number'], trip['bus']['model'], bus_services
        )

        trips << {
          from_id: from.id,
          to_id: to.id,
          bus_id: bus.id,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        }
      end

      Trip.import trips, batch_size: 1000
    end
  end

  private

  def find_or_create_city(name)
    return cities[name] if cities.key?(name)

    cities[name] = City.create(name: name)
  end

  def find_or_create_service(name)
    return services[name] if services.key?(name)

    services[name] = Service.create(name: name)
  end

  def find_or_create_bus(number, model, services)
    return buses[number] if buses.key?(number)

    buses[number] = Bus.create(
      number: number,
      model: model,
      services: services
    )
  end
end
