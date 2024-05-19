class TripsImporter
  class << self
    def call(filename)
      file_stream = File.open(filename, 'r')
      chunk_size = 1000
      streamer = Json::Streamer.parser(file_io: file_stream, chunk_size: chunk_size)

      ActiveRecord::Base.connection.execute <<~EOF
        DELETE FROM trips;
        DELETE FROM buses_services;
        DELETE FROM cities;
        DELETE FROM buses;
        DELETE FROM services;
      EOF

      batch = []

      streamer.get(nesting_level: 1) do |trip|
        if batch.size == 1000
          process_batch(batch)
          batch = []
        end

        batch << trip
      end

      process_batch(batch) if batch.size > 0
    end

    private

    def process_batch(batch)
      cities = {}
      buses = {}
      services = {}
      trips = []
      buses_services = []

      batch.each do |trip_hash|
        from  = cities[trip_hash['from']] ||= City.new(name: trip_hash['from'])
        to    = cities[trip_hash['to']]   ||= City.new(name: trip_hash['to'])
        bus   = buses[[
          trip_hash['bus']['number'],
          trip_hash['bus']['model']
        ]] ||= Bus.new(
          number: trip_hash['bus']['number'],
          model: trip_hash['bus']['model'],
        )

        buses_services = Service.where(name: trip_hash['bus']['services']).map do |service_name|
          service = services[service_name] ||= Service.new(name: service_name)
          BusesService.new(bus: bus, service: service)
        end

        trips << Trip.new(
          from:             from,
          to:               to,
          bus:              bus,
          start_time:       trip_hash['start_time'],
          duration_minutes: trip_hash['duration_minutes'],
          price_cents:      trip_hash['price_cents'],
        )
      end

      ActiveRecord::Base.transaction do
        City.import!(services.values, on_duplicate_key_ignore: true)
        City.import!(cities.values, on_duplicate_key_ignore: true)
        Bus.import!(buses.values, on_duplicate_key_ignore: true)
        BusesService.import!(buses_services, on_duplicate_key_ignore: true)
        Trip.import!(trips, on_duplicate_key_ignore: true)
      end
    end
  end
end
