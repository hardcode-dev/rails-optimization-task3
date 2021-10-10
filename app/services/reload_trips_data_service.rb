# frozen_string_literal: true

class ReloadTripsDataService
  CHUNK_SIZE = 100

  def initialize(file_name)
    @file_name      = file_name
    @cities         = {}
    @services       = {}
    @buses          = {}
    @buses_services = {}
    @trips          = []
  end

  def call
    json = JSON.parse(File.read(file_name))

    ActiveRecord::Base.transaction do
      delete_old_data
      json.each do |trip|
        from = find_or_create_city(trip['from'])
        to = find_or_create_city(trip['to'])
        bus = find_or_create_bus(trip['bus']['number'], trip['bus']['model'])
  
        trip['bus']['services'].each do |service|
          s = find_or_create_service(service)
          find_or_create_buses_services(bus, s)
        end

        trips << Trip.new(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        )

        import_to_db if trips.size == CHUNK_SIZE
      end
  
      import_to_db
    end

    nil
  end

  private

  attr_reader :file_name, :cities, :services, :buses, :buses_services, :trips

  def delete_old_data
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusesService.delete_all
  end

  def find_or_create_city(city)
    cities[city] ||= City.find_or_create_by(name: city)
  end
  
  def find_or_create_bus(number, model)
    buses[number] ||= Bus.find_or_create_by(number: number, model: model)
  end
  
  def find_or_create_service(service)
    services[service] ||= Service.find_or_create_by(name: service)
  end

  def find_or_create_buses_services(bus, service)
    buses_services["#{bus.id}_#{service.id}"] ||= BusesService.find_or_create_by(bus: bus, service: service)
  end

  def import_to_db
    Trip.import trips
    @trips = []
  end
end