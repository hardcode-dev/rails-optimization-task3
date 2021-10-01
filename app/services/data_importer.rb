# frozen_string_literal: true

class DataImporter
  def self.call(file_name)
    json = JSON.parse(File.read(file_name))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      all_services = Service::SERVICES.map { |s| [s, Service.create(name: s).id] }.to_h
      buses_services = {}
      cities = {}
      json.each do |trip|
        cities[trip['from']] ||= City.create(name: trip['from']).id
        cities[trip['to']] ||= City.create(name: trip['to']).id
        bus = Bus.find_or_create_by(model: trip['bus']['model'], number: trip['bus']['number'])
        buses_services[bus.id] ||= []
        buses_services[bus.id] |= trip['bus']['services'].map{ |el| all_services[el] }

        Trip.create!(
          from_id: cities[trip['from']],
          to_id: cities[trip['to']],
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        )
      end
      buses_services.each do |bus_id, services|
        BusesService.import(services.map { |service_id| { bus_id: bus_id, service_id: service_id } })
      end
    end
  end
end
