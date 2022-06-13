# frozen_string_literal: true

class LoadData
  attr_accessor :json, :cities, :services, :buses, :buses_services, :trips

  def initialize(json)
    @json           = json
    @cities         = {}
    @services       = {}
    @buses          = {}
    @buses_services = []
    @trips          = []
  end

  def load
    json.each do |trip|
      city_from  = trip['from']
      city_to    = trip['to']
      bus_number = trip['bus']['number']

      add_item(cities, trip['from'])
      add_item(cities, trip['to'])

      trip['bus']['services'].each do |service|
        add_item(services, service)
      end

      add_bus(buses, trip['bus'])

      trips.push(
        from_id:          cities[city_from][:id],
        to_id:            cities[city_to][:id],
        bus_id:           buses[bus_number][:id],
        start_time:       trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents:      trip['price_cents']
      )
    end

    City.import(cities.values)
    Service.import(services.values)
    Bus.import(buses.values)
    BusesService.import(buses_services.uniq)
    Trip.import(trips)

    nil
  end

  def add_item(collection, item_name)
    return if collection.keys.include?(item_name)

    collection[item_name] = {
      id:   collection.size + 1,
      name: item_name
    }
  end

  def add_bus(collection, bus)
    bus_id = collection.size + 1
    number = bus['number']

    collection[number] ||= { id: bus_id, number: number }
    collection[number][:model] = bus['model']

    bus['services'].map do |service|
      buses_services.push(
        bus_id: collection[number][:id],
        service_id: services[service][:id]
      )
    end
  end
end
