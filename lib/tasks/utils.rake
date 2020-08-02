# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.measure do
    json = JSON.parse(File.read(args.file_name))

    cities = {}
    allowed_services = {}
    trips = []
    cn = 0

    limit = 500

    ActiveRecord::Base.transaction do
      PgHero.reset_query_stats
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      json.each do |trip|
        #TODO тут мы могли бы проверять наличие ключа методом has_key? вместо present? - но тут мы хотим убедиться, что есть содерживое
        cities[trip['from']] = City.find_or_create_by(name: trip['from']) unless cities[trip['from']].present?
        cities[trip['to']] = City.find_or_create_by(name: trip['to']) unless cities[trip['to']].present?

        from = cities[trip['from']]
        to = cities[trip['to']]
        services = []

        trip['bus']['services'].each do |service|
          allowed_services[service] = Service.find_or_create_by(name: service) if allowed_services[service].blank?
          services << allowed_services[service]
        end

        bus = nil
        if Bus.find_by(number: trip['bus']['number'], model: trip['bus']['model']).present?
          bus = Bus.find_by(number: trip['bus']['number'], model: trip['bus']['model'])
        else
          bus = Bus.create(number: trip['bus']['number'], model: trip['bus']['model'], services: services)
        end

        cn += 1

        trips << [ from.id, to.id, bus.id, trip['start_time'], trip['duration_minutes'], trip['price_cents'] ]
        #puts trips.inspect
        if cn == limit
          Trip.import(%i[from_id to_id bus_id start_time duration_minutes price_cents], trips, validate: true)
          trips = []
          cn = 0
        end

        # Trip.create!(
        #   from: from,
        #   to: to,
        #   bus: bus,
        #   start_time: trip['start_time'],
        #   duration_minutes: trip['duration_minutes'],
        #   price_cents: trip['price_cents'],
        # )
      end

      if trips.present?
        Trip.import(%i[from_id to_id bus_id start_time duration_minutes price_cents], trips, validate: true)
        trips = nil
      end
    end
  end

  puts time
end
