# frozen_string_literal: true

class ImportTrips
  def initialize(filename)
    @json_data = JSON.parse(File.read(filename), symbolize_names: true)
    @buses = []
    @trips = []
  end

  def call!
    prepare_tables

    ActiveRecord::Base.transaction do
      Bus.import(json_data.map { |trip| build_bus(trip: trip) }.uniq, recursive: true)

      Trip.import(json_data.map { |trip| build_trip(trip: trip) })
    end
  end

  private

  attr_reader :json_data, :trips

  def build_bus(trip:)
    bus = fetch_bus(number: trip[:bus][:number])
    trip[:bus][:services].each do |service|
      build_bus_service(bus: bus, service: service)
    end
    bus.model = trip[:bus][:model]
    bus
  end

  def build_trip(trip:)
    find_bus(number: trip[:bus][:number]).trips.build(
      from_id: fetch_city(name: trip[:from]).id,
      to_id: fetch_city(name: trip[:to]).id,
      **trip.slice(:start_time, :duration_minutes, :price_cents)
    )
  end

  def build_bus_service(bus:, service:)
    @build_bus_service ||= Hash.new do |hash, key|
      hash[key] = key[0].bus_services.build(service: fetch_service(name: key[1]))
    end

    @build_bus_service[[bus, service]]
  end

  def fetch_city(name:)
    @fetch_city ||= Hash.new do |hash, key|
      hash[key] = City.create(name: key)
    end

    @fetch_city[name]
  end

  def fetch_service(name:)
    @fetch_service ||= Hash.new do |hash, key|
      hash[key] = Service.create(name: key)
    end

    @fetch_service[name]
  end

  def fetch_bus(number:)
    @fetch_bus ||= Hash.new do |hash, key|
      hash[key] = Bus.new(number: key)
    end

    @fetch_bus[number]
  end

  def find_bus(number:)
    @find_bus ||= Hash.new do |hash, key|
      hash[key] = Bus.find_by(number: key)
    end

    @find_bus[number]
  end

  def prepare_tables
    BusService.delete_all
    Trip.delete_all
    Bus.delete_all
    Service.delete_all
    City.delete_all
  end
end
