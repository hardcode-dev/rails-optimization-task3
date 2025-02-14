class TripsImporter
  def initialize(file = 'fixtures/small.json')
    @file = file
  end

  def self.call(...)
    new(...).call
  end

  def call
    json = JSON.parse(File.read(file))

    clean_database

    ActiveRecord::Base.transaction do
      # TODO
      # файл large довольно быстро читается на самом деле


      # unique index + insert cities
      # bulk insert типа
      # insert buses_services + test
      #
      # bus = Bus.create!(model: "Икарус", number: "100")
      trips = []
      json.each do |trip|
        from = City.find_or_create_by(name: trip['from'])
        to = City.find_or_create_by(name: trip['to'])

        service_names = trip['bus']['services'].map { |name| { name: name } }
        service_ids = Service.upsert_all(service_names, unique_by: :name).rows.flatten

        number = trip['bus']['number']

        bus = Bus.upsert_all([number: number, model: trip['bus']['model']], unique_by: :number, on_duplicate: :update)
        # bus = Bus.find(bus.first["id"])
        # bus.update(service_ids: service_ids.rows.flatten)
        bus_id = bus.first["id"]

        # TODO!!! + test
        # #   "insert into buses_services(bus_id, service_id) values (?, ?)",

        if service_ids.present?
          values = service_ids.map { |service_id| "(#{bus_id}, #{service_id})" }.join(", ")
          # binding.pry
          sql = "INSERT INTO buses_services (bus_id, service_id) VALUES #{values};"
          ActiveRecord::Base.connection.execute(sql)
        end

        # binding.pry
        # bus = Bus.find_or_create_by(number: number)
        # bus.update(model: trip['bus']['model'], service_ids: service_ids.rows.flatten)

        trips.push({
          from_id: from.id,
          to_id: to.id,
          bus_id: bus_id,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
          })
      end

      Trip.insert_all trips
    end
  end

  private

  attr_reader :file

  def clean_database
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end
end
