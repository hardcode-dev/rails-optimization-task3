class ReloadJson
  def initialize(file_name)
    @file_name = file_name
  end

  def call
    json = JSON.parse(File.read(@file_name))
    trips = []
    buses = {}
    services = {}
    cities = {}
    bus_services = {}

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      BusesService.delete_all

      json.each do |trip|
        from = find_or_new_city!(cities, trip['from'])
        to = find_or_new_city!(cities, trip['to'])

        bus = buses[trip['bus']['number']]
        unless bus
          bus = Bus.new(number: trip['bus']['number'])
          bus.model = trip['bus']['model']
          trip['bus']['services'].each do |service|
            s = find_or_new_service!(services, service)
            find_or_new_bus_service!(bus_services, bus, s)
          end
          buses[trip['bus']['number']] = bus
        end

        trips << Trip.new(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents']
        )
      end

      City.import! cities.values
      Service.import! services.values
      Bus.import! buses.values
      BusesService.import! bus_services.values.map(&:values).flatten
      Trip.import! trips
    end
  end

  def find_or_new_city!(cities, name)
    found = cities[name]
    unless found
      found = City.new(name: name)
      cities[name] = found
    end
    found
  end

  def find_or_new_service!(services, name)
    found = services[name]
    unless found
      found = Service.new(name: name)
      services[name] = found
    end
    found
  end

  def find_or_new_bus_service!(bus_services, bus, service)
    found = bus_services.dig(bus, service)
    unless found
      found = BusesService.new(bus: bus, service: service)
      bus_services[bus] = {} unless bus_services[bus]
      bus_services[bus][service] = found
    end
    found
  end
end
