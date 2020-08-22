# frozen_string_literal: true

class ImportTrips
  TRIP_COLUMNS = %i(from_id to_id bus_id start_time duration_minutes price_cents).freeze
  # BATCH_SIZE = 7_500

  def initialize(filename)
    @json_data = JSON.parse(File.read(filename), symbolize_names: true)
    @buses = []
    @trips = []
  end

  def call!
    prepare_tables

    ActiveRecord::Base.transaction do
      json_data.each do |trip|
        trip[:bus][:services].map! do |service|
          fetch_service(name: service)
        end
        bus = fetch_bus(number: trip[:bus][:number])
        bus.update(**trip[:bus])

        aggregate_trip(bus: bus, trip: trip)
      end

      Trip.import(TRIP_COLUMNS, trips)
    end
  end

  private

  attr_reader :json_data, :trips

  def aggregate_trip(bus:, trip:)
    trips << {
      from_id: fetch_city(name: trip[:from]).id,
      to_id: fetch_city(name: trip[:to]).id,
      bus_id: bus.id,
      **trip.slice(:start_time, :duration_minutes, :price_cents)
    }
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
      hash[key] = Bus.create(number: key)
    end

    @fetch_bus[number]
  end

  def prepare_tables
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end
end
