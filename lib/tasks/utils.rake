# frozen_string_literal: true

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

task :reload_json, [:file_name] => :environment do |_task, args|
  # Vernier.run(out: "time_profile.json") do
  # profile = StackProf.run(mode: :wall, raw: true) do
    # Rails.logger.level = Logger::DEBUG
    # ActiveRecord::Base.logger = Logger.new STDOUT

    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    json = JSON.parse(File.read(args.file_name))

    ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE buses_services DROP CONSTRAINT IF EXISTS for_upsert;
      ALTER TABLE buses_services
        ADD CONSTRAINT for_upsert UNIQUE (bus_id, service_id);
    SQL

    ActiveRecord::Base.transaction do
      cities = {}
      ac_services = {}
      ac_buses = {}
      trips = []
      services = []

      json.each do |trip|
        cities[trip['from']] ||= City.create!(name: trip['from'])
        cities[trip['to']] ||= City.create!(name: trip['to'])
        ac_buses[trip['bus']['number']] ||= Bus.create(number: trip['bus']['number'], model: trip['bus']['model'])

        trip['bus']['services'].each do |service|
          ac_services[service] ||= Service.create!(name: service)
          s = [ac_buses[trip['bus']['number']].id, ac_services[service].id]
          services << s
        end

        trips << [cities[trip['from']].id, cities[trip['to']].id, trip['start_time'], trip['duration_minutes'],
                  trip['price_cents'], ac_buses[trip['bus']['number']].id]

        next unless trips.length == 1000

        BusesService.import %i[bus_id service_id], services, validate: false, on_duplicate_key_ignore: true
        Trip.import %i[from_id to_id start_time duration_minutes price_cents bus_id], trips, validate: false
        trips = []
        services = []
      end

      BusesService.import %i[bus_id service_id], services, validate: false, on_duplicate_key_ignore: true
      Trip.import %i[from_id to_id start_time duration_minutes price_cents bus_id], trips, validate: false
      # puts format('MEMORY USAGE: %d MB', (`ps -o rss= -p #{Process.pid}`.to_i / 1024))
    end
  # end

  ActiveRecord::Base.connection.execute <<-SQL
      ALTER TABLE buses_services DROP CONSTRAINT IF EXISTS for_upsert;
  SQL
  File.write('stackprof.json', JSON.generate(profile))
  # end
end
