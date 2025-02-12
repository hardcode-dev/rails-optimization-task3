class TripsImporter
  def initialize(file = 'fixtures/small.json')
    @file = file
  end

  def self.call(...)
    new(...).call
  end

  def call
    json = JSON.parse(File.read(file))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

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
        services = []
        trip['bus']['services'].each do |service|
          s = Service.find_or_create_by(name: service)
          services << s
        end
        bus = Bus.find_or_create_by(number: trip['bus']['number'])
        bus.update(model: trip['bus']['model'], services: services)

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
end