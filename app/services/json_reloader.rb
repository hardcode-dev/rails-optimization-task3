# frozen_string_literal: true

class JsonReloader
  def initialize(file)
    @file           = file
    @buses          = {}
    @cities         = {}
    @services       = {}
    @buses_services = {}
    @trips          = []
  end

  def call
    json = JSON.parse(File.read(@file))

    ActiveRecord::Base.transaction do
      delete_all_data
      add_new_data(json)
    end
  end

  private

  def delete_all_data
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end

  def add_new_data(json)
    json.each do |trip|
      from = create_or_find_city(trip['from'])
      to   = create_or_find_city(trip['to'])
      bus  = create_or_find_bus(trip['bus'])

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

  def create_or_find_city(name)
    city = @cities[name]

    if city.nil?
      city = City.new(name: name)
      @cities[name] = city
    end

    city
  end

  def create_or_find_bus(bus_object)
    number   = bus_object['number']
    model    = bus_object['model']
    bus = @buses[number]

    if bus.nil?
      bus = Bus.new(number: number, model: model)
      service_processing(bus, bus_object['services'])

      @buses[number] = bus
    end

    bus
  end

  def service_processing(bus, services)
    services.each do |name|
      service = @services[name]

      if service.nil?
        service = Service.new(name: name)
        @services[name] = service
      end

      bus_service = BusesService.new(bus: bus, service: service)
      @buses_services[bus] ||= {}
      @buses_services[bus][service] = bus_service
    end
  end

  def import_data
    City.import         @cities.values
    Bus.import          @buses.values
    Service.import      @services.values
    BusesService.import @buses_services.values.map(&:values).flatten
    Trip.import         @trips
  end
end
