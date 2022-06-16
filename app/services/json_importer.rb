# frozen_string_literal: true

require 'oj'

class JsonImporter
  attr_accessor :trips, :cached_services, :buses_services, :cities, :buses, :new_bus_services

  def initialize
    @trips = []
    @cached_services = []
    @buses_services = []
    @cities = []
    @buses = []
    @new_bus_services = []
  end

  def call(file_name: "medium_json")
    time = Benchmark.realtime do
      import_file(file_name)
    end

    puts "finish in #{time.round(2)}"

    # import_file(file_name)
  end

  private

  BATCH_SIZE = 100

  def import_file(file_name)
    json = Oj.load(File.read(file_name))

    ActiveRecord::Base.transaction do
      clear_db

      json.each do |trip|
        from_id = fetch_city_id(trip['from'])
        to_id = fetch_city_id(trip['to'])
        bus_id = fetch_bus_id(trip['bus']['number'], trip['bus']['model'])

        trip['bus']['services'].each do |service|
          service_id = fetch_service(service)
          create_buses_service(bus_id, service_id)
        end

        BusesService.import!(@new_bus_services) if @new_bus_services.any?
        @new_bus_services = []

        @trips << Trip.new(
          from_id: from_id,
          to_id: to_id,
          bus_id: bus_id,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        )

        if @trips.size == BATCH_SIZE
          Trip.import!(@trips)
          @trips = []
        end
      end

      Trip.import!(@trips) if @trips.any?
    end
  end

  def fetch_city_id(name)
    cached_city = @cities.find { |city| city[:name] == name }

    return cached_city[:id] if cached_city.present?

    id = City.create(name: name).id
    @cities << { id: id, name: name }

    id
  end

  def fetch_service(name)
    cached_service = @cached_services.find { |service| service[:name] == name }

    if cached_service.present?
      return cached_service[:id]
    end

    id = Service.create(name: name).id
    @cached_services << { id: id, name: name }

    id
  end

  def create_buses_service(bus_id, service_id)
    cached_service = @buses_services.find do |service|
      service[:bus_id] == bus_id && service[:service_id] == service_id
    end

    if cached_service.present?
      return
    end

    new_service = BusesService.new(bus_id: bus_id, service_id: service_id)
    @new_bus_services << new_service
    @buses_services << { bus_id: new_service.bus_id, service_id: new_service.service_id }
  end

  def fetch_bus_id(number, model)
    cached_bus = @buses.find do |bus|
      bus[:number] == number && bus[:model] == model
    end

    if cached_bus.present?
      return cached_bus[:id]
    end

    new_bus_id = Bus.create(number: number, model: model).id
    @buses << { number: number, model: model, id: new_bus_id }

    new_bus_id
  end

  def clear_db
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end
end
