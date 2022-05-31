# frozen_string_literal: true

require 'activerecord-import'
require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'

require 'oj'

class JSONImporter
  BATCH_SIZE = 2000

  # place in Redis if collection will grow
  def cached_services
    @cached_services ||= {}
  end

  # place in Redis if collection will grow
  def cached_cities
    @cached_cities ||= {}
  end

  # place in Redis if collection will grow
  def cached_buses
    @cached_buses ||= {}
  end

  def call(path)
    json = Oj.load(File.read(path))

    ActiveRecord::Base.transaction do
      flush_db

      json.each_slice(BATCH_SIZE) do |slice|
        trip_slice = []
        buses_slice = []
        buses_services = Hash.new([])

        slice.each do |trip|
          service_ids = fetch_services_ids(trip)

          bus_key = "#{trip['bus']['number']}_#{trip['bus']['model']}"
          bus = cached_buses[bus_key]

          unless bus
            bus = build_bus(trip)

            cached_buses[bus_key] = bus

            buses_slice << bus
          end

          buses_services[bus[:id]] = service_ids

          trip_slice << build_trip(trip, bus)
        end

        import_buses(buses_slice)
        import_services(buses_services)
        import_trips(trip_slice)
      end
    end
  end

  def import_trips(trips)
    Trip.import(trips)
  end

  def import_buses(buses)
    Bus.import(buses)
  end

  def import_services(buses_services)
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("delete from buses_services where bus_id in (#{buses_services.keys.join(', ')});")

      buses_services.each_pair do |k, ids|
        next unless ids.any?

        ActiveRecord::Base.connection.execute(
          "insert into buses_services (bus_id, service_id) VALUES #{ids.map! { |id| "(#{k},#{id})," }.join.chomp(',')};"
        )
      end
    end
  end

  def build_trip(trip, bus)
    Hash(
      from_id: city_with_cache(trip['from']),
      to_id: city_with_cache(trip['to']),
      bus_id: bus[:id],
      start_time: trip['start_time'],
      duration_minutes: trip['duration_minutes'],
      price_cents: trip['price_cents']
    )
  end

  def build_bus(trip)
    Hash(
      id: Bus.connection.execute("SELECT nextval('public.buses_id_seq');")[0]['nextval'],
      number: trip['bus']['number'],
      model: trip['bus']['model']
    )
  end

  def flush_db
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end

  def fetch_services_ids(trip)
    trip['bus']['services'].map do |name|
      if cached_services[name].blank?
        cached_services[name] = Service.create(name: name).id
      end

      cached_services[name]
    end
  end

  def city_with_cache(name)
    if cached_cities[name].blank?
      cached_cities[name] = City.create(name: name).id
    end

    cached_cities[name]
  end
end
