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
      # нужно написать тест сначала
      # вынести в класс для этого будет удобно, я думаю
      # bulk insert (cities, buses, services, trips)
      # in batches надо, видимо

      # cities = Set.new
      # trip_services = Set.new
      # buses = []

      json.each do |trip|
        from = City.find_or_create_by(name: trip['from'])
        to = City.find_or_create_by(name: trip['to'])

        service_names = trip['bus']['services'].map { |name| { name: name } }
        service_ids = Service.upsert_all(service_names, unique_by: :name)

        bus = Bus.find_or_create_by(number: trip['bus']['number'])
        bus.update(model: trip['bus']['model'], service_ids: service_ids.rows.flatten)

        Trip.create!(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        )
      end
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
