# frozen_string_literal: true

class DataImporter
  def self.call(file_name)
    json = JSON.parse(File.read(file_name))

    buses_services = {}
    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      json.each do |trip|
        from = City.find_or_create_by(name: trip['from'])
        to = City.find_or_create_by(name: trip['to'])
        services = []
        trip['bus']['services'].each do |service|
          s = Service.find_or_create_by(name: service)
          services << s.id
        end
        bus = Bus.find_or_create_by(model: trip['bus']['model'], number: trip['bus']['number'])
        buses_services[bus.id] ||= []
        buses_services[bus.id] |= services

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
    buses_services.each do |bus_id, services|
      BusesService.import(services.map { |service_id| { bus_id: bus_id, service_id: service_id } })
    end
  end
end
