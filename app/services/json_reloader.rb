# frozen_string_literal: true

class JsonReloader
  def initialize(file_name)
    @file_name = file_name

    @cities = {}
    @buses = {}
    @services = {}
    @trips = []
    @buses_services = {}
  end

  def call
    json = JSON.parse(File.read(@file_name))

    ActiveRecord::Base.transaction do
      clear_data

      json.each do |trip|
        from = find_or_initialize_city(trip['from'])
        to = find_or_initialize_city(trip['to'])

        bus_row = trip['bus']
        bus = find_or_initialize_bus(bus_row['number'], bus_row['model'])

        bus_row['services'].each do |name|
          service = find_or_initialize_service(name)
          find_or_initialize_bus_service(bus, service)
        end

        @trips << Trip.new(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents']
        )
      end

      import_data
    end
  end

  private

  def clear_data
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end

  def import_data
    City.import @cities.values
    Bus.import @buses.values
    Service.import @services.values
    BusesService.import @buses_services.values.map(&:values).flatten
    Trip.import @trips
  end

  def find_or_initialize_city(name)
    city = @cities[name]
    if city.nil?
      city = City.new(name: name)
      @cities[name] = city
    end
    city
  end

  def find_or_initialize_bus(number, model)
    bus = @buses[number]
    if bus.nil?
      bus = Bus.new(number: number, model: model)
      @buses[number] = bus
    end
    bus
  end

  def find_or_initialize_service(name)
    service = @services[name]
    if service.nil?
      service = Service.new(name: name)
      @services[name] = service
    end
    service
  end

  def find_or_initialize_bus_service(bus, service)
    bus_service = BusesService.new(bus: bus, service: service)
    @buses_services[bus] ||= {}
    @buses_services[bus][service] = bus_service
  end
end
