# frozen_string_literal: true

# Populates database with records from json file
class PopulateDatabase
  include Singleton

  class << self
    delegate :call, to: :instance
  end

  def call(file_path:, validate: false)
    json = JSON.parse(File.read(file_path))

    clear_database
    process_common_entities(json, validate)
    process_trips(json, validate)
  end

  private

  def clear_database
    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      BusesService.delete_all
    end
  end

  def process_common_entities(json, validate)
    cities = Set.new
    buses = Set.new
    services = Set.new

    json.each do |trip|
      cities << { name: trip['from'] }
      cities << { name: trip['to'] }
      buses  << { number: trip['bus']['number'], model: trip['bus']['model'] }

      trip['bus']['services'].each { |service_name| services << { name: service_name } }
    end

    City.import cities.to_a, validate: validate
    Bus.import buses.to_a, validate: validate
    Service.import services.to_a, validate: validate
  end

  def process_trips(json, validate)
    cities = City.pluck(:name, :id).to_h
    buses = Bus.all.each_with_object({}) do |bus, memo|
      key = [bus.number, bus.model]
      memo[key] = bus.id
    end
    services = Service.pluck(:name, :id).to_h
    buses_services = Set.new
    trips = []

    json.each do |trip|
      bus_key = [trip['bus']['number'], trip['bus']['model']]
      bus_id = buses[bus_key]
      trip['bus']['services'].each do |service_name|
        service_id = services[service_name]
        buses_services << { bus_id: bus_id, service_id: service_id }
      end

      trips << {
        from_id: cities[trip['from']],
        to_id: cities[trip['to']],
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents'],
        bus_id: bus_id
      }
    end

    BusesService.import buses_services.to_a, validate: false
    Trip.import trips, validate: validate, batch_size: 1_000
  end
end
