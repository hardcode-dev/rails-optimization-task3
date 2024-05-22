class TripsImporter
  class << self
    def call(filename)
      # json = JSON.parse(File.read(filename))
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
      services_by_names = Service::SERVICES.map { |service_name| Service.create!(name: service_name) }.index_by(&:name)
      cities = {}
      buses = {}

      streamer.get(nesting_level: 1) do |trip|
      # json.each do |trip|
        if batch.size == 1000
          process_batch(batch, services_by_names, cities, buses)
          batch = []
        end

        batch << trip
      end

      process_batch(batch, services_by_names, cities, buses) if batch.size > 0
    end

    private

    def process_batch(batch, services_by_names, cities, buses)
      flat = true if buses.any?
      # trips = []
      buses_services = []

      # storage = Hash.new(0)

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

        # storage[[from.name, to.name, bus.number, bus.model]] += 1

        # trips << Trip.new(
        #   from:             from,
        #   to:               to,
        #   bus:              bus,
        #   start_time:       trip_hash['start_time'],
        #   duration_minutes: trip_hash['duration_minutes'],
        #   price_cents:      trip_hash['price_cents'],
        # )
      end

      ActiveRecord::Base.transaction do
        City.import!(cities.values, on_duplicate_key_ignore: true)
        Bus.import!(buses.values.select {_1.id.nil?}, on_duplicate_key_ignore: true)
        BusesService.import!(buses_services, on_duplicate_key_ignore: true)

        # Trip.import!(trips)
        #

        trips_command = "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"

        ActiveRecord::Base.connection.raw_connection.copy_data(trips_command) do

          batch.each do |trip|
            from_id = cities[trip['from']].id
            to_id = cities[trip['to']].id
            bus_id = buses[[ trip['bus']['number'], trip['bus']['model'] ]].id
            ActiveRecord::Base.connection.raw_connection.put_copy_data(
              "#{from_id};#{to_id};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus_id}\n"
            )
          end
        end
      rescue => e
        binding.pry

      end
    end
  end
end
