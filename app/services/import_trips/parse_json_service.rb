module ImportTrips::ParseJsonService
  extend self

  def call(file_path:)
    time = Benchmark.measure do
      file_json = Oj.load(File.read(file_path))

      parsing(file_json)
    end

    puts time
  end

  private

  def parsing(json)
    cities = {}
    allowed_services = {}
    uniq_buses = {}
    trips = []
    cn = 0

    limit = 2000

    ActiveRecord::Base.transaction do
      PgHero.reset_query_stats
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      json.each do |trip|
        #TODO тут мы могли бы проверять наличие ключа методом has_key? вместо present? - но тут мы хотим убедиться, что есть содерживое
        cities[trip['from']] = City.select(:id).find_or_create_by(name: trip['from']) unless cities[trip['from']].present?
        cities[trip['to']] = City.select(:id).find_or_create_by(name: trip['to']) unless cities[trip['to']].present?

        from = cities[trip['from']]
        to = cities[trip['to']]
        services = []

        trip['bus']['services'].each do |service|
          allowed_services[service] = Service.find_or_create_by(name: service) if allowed_services[service].blank?
          services << allowed_services[service]
        end

        if (bus_id = uniq_buses["#{trip['bus']['model']}_#{trip['bus']['number']}"]).blank?
          uniq_buses["#{trip['bus']['model']}_#{trip['bus']['number']}"] =
            Bus.create(number: trip['bus']['number'], model: trip['bus']['model'], services: services).id
          bus_id = uniq_buses["#{trip['bus']['model']}_#{trip['bus']['number']}"]
        end

        cn += 1

        trips << [ from.id, to.id, bus_id, trip['start_time'], trip['duration_minutes'], trip['price_cents'] ]

        if cn == limit
          Trip.import(%i[from_id to_id bus_id start_time duration_minutes price_cents], trips, validate: true)
          trips = []
          cn = 0
        end
      end

      if trips.present?
        Trip.import(%i[from_id to_id bus_id start_time duration_minutes price_cents], trips, validate: true)
        trips = nil
      end
    end
  end
end
