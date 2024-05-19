class TripsImporter
  class << self
    def call(filename)
      # json = JSON.parse(File.read(filename))
      file_stream = File.open(filename, 'r')
      chunk_size = 100
      streamer = Json::Streamer.parser(file_io: file_stream, chunk_size: chunk_size)

      ActiveRecord::Base.connection.execute <<~EOF
        DELETE FROM trips;
        DELETE FROM buses_services;
        DELETE FROM cities;
        DELETE FROM buses;
        DELETE FROM services;
      EOF

      batch = []
      services_by_names = Service::SERVICES.map { |service_name| Service.create!(name: service_name) }.index_by(&:name)

      streamer.get(nesting_level: 1) do |trip|
      # json.each do |trip|
        if batch.size == 100
          process_batch(batch, services_by_names)
          batch = []
        end

        batch << trip
      end

      process_batch(batch, services_by_names) if batch.size > 0
    end

    private

    def process_batch(batch, services_by_names)
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

        buses_services = trip_hash['bus']['services'].map do |service_name|
          BusesService.new(bus: bus, service: services_by_names[service_name])
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
        City.import!(cities.values, on_duplicate_key_ignore: true)
        Bus.import!(buses.values, on_duplicate_key_ignore: true)
        BusesService.import!(buses_services, on_duplicate_key_ignore: true)
        Trip.import!(trips, on_duplicate_key_ignore: true)
      end
    end
  end
end
