require 'benchmark'

class ImportService
  def initialize(file_name)
    @file_name = file_name

    @trips_collection = []
    @trips_count = 0

    @buses_ids = {}
    @buses_struct = {}

    @cities = {}
  end

  def process
    new_data = Benchmark.realtime do
      ActiveRecord::Base.transaction do
        clean_data
        Json::Streamer
          .parser(file_io: File.open(@file_name, 'r'), chunk_size: 5000)
          .get(nesting_level:1) do |object|
            perform_trip object
          end
        flush_trips
        flush_cities
        flush_bus
      end
    end
    puts "new_data #{new_data}"
  end

  def clean_data
    City.delete_all
    Bus.delete_all
    Trip.delete_all
  end

  def perform_trip(trip)
    bus_id = push_bus(
      [trip['bus']['number'], trip['bus']['model']],
      Bus::SERVICES & trip['bus']['services']
    )

    push_trips([
      push_city(trip['from']),
      push_city(trip['to']),
      bus_id,
      trip['start_time'], trip['duration_minutes'], trip['price_cents']
    ])
  end

  def push_trips(object)
    @trips_collection.push(object)
    @trips_count += 1
    flush_trips if @trips_count > 100
  end

  def flush_trips
    Trip.import(
      %w[from_id to_id bus_id start_time duration_minutes price_cents],
      @trips_collection
    )
    @trips_count = 0
    @trips_collection = []
  end

  def push_bus(object, services)
    bus_id = get_bus_id(object)
    @buses_struct[bus_id] = [bus_id, *object, services]
    bus_id
  end

  def get_bus_id(object)
    @buses_ids[object] ||= SecureRandom.uuid
  end

  def flush_bus
    Bus.import(%i[id number model services], @buses_struct.values)
  end

  def push_city(name)
    @cities[name] ||= SecureRandom.uuid
  end

  def flush_cities
    City.import(%i[name id], @cities.to_a)
  end
end
