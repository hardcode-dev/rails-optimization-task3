# frozen_string_literal: true

class WriteDumpService < ApplicationService
  CHUNK_SIZE = 100

  def initialize(file_name)
    @file_name = File.join(Rails.root, file_name)
    @file_stream = File.open(@file_name, 'r')
    @streamer = Json::Streamer.parser(file_io: @file_stream, chunk_size: CHUNK_SIZE)
    set_empty_data
  end

  def call
    @streamer.get(nesting_level: 0) do |batch|
      batch.each do |trip|
        from = get_city(trip['from'])
        to = get_city(trip['to'])
        bus = get_bus(trip['bus']['number'], trip['bus']['model'])

        trip['bus']['services'].each do |service_name|
          service = get_service(service_name)
          get_bus_service(bus, service)
        end

        get_trip(from, to, bus, trip)
      end

      write_data
      set_empty_data
    end
  end

  private

  def set_empty_data
    @cities = {}
    @services = {}
    @buses = {}
    @bus_services = []
    @trips = []
  end

  def write_data
    City.import @cities.values
    Service.import @services.values
    Bus.import @buses.values
    BusesService.import @bus_services
    Trip.import @trips
  end

  def get_trip(from, to, bus, trip)
    @trips << Trip.new(
      from: from,
      to: to,
      bus: bus,
      start_time: trip['start_time'],
      duration_minutes: trip['duration_minutes'],
      price_cents: trip['price_cents']
    )
  end

  def get_city(name)
    city = @cities[name]
    if city.nil?
      city = City.new(name: name)
      @cities[name] = city
    end

    city
  end

  def get_bus(number, model)
    bus = @buses[number]
    if bus.nil?
      bus = Bus.new(number: number, model: model)
      @buses[number] = bus
    end

    bus
  end

  def get_service(service_name)
    service = @services[service_name]
    if service.nil?
      service = Service.new(name: service_name)
      @services[service_name] = service
    end

    service
  end

  def get_bus_service(bus, service)
    bus_service = BusesService.new(bus: bus, service: service)
    @bus_services << bus_service
  end
end
