# frozen_string_literal: true

class DataImporter
  BATCH_SIZE = 10_000

  def self.call(file_name)
    json = JSON.parse(File.read(file_name))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      all_services = Service::SERVICES.map { |s| [s, Service.create(name: s).id] }.to_h
      buses = {}
      cities = {}
      trips = []
      i = 1
      json.each do |trip|
        cities[trip['from']] ||= City.create(name: trip['from']).id
        cities[trip['to']] ||= City.create(name: trip['to']).id
        bus_key = "#{trip['bus']['number']}#{trip['bus']['model']}"
        buses[bus_key] ||= {}
        buses[bus_key][:id] ||= Bus.create(model: trip['bus']['model'], number: trip['bus']['number']).id
        if buses[bus_key][:services].present?
          buses[bus_key][:services] |= trip['bus']['services'].map{ |el| all_services[el] }
        else
          buses[bus_key][:services] = trip['bus']['services'].map{ |el| all_services[el] }
        end

        trips << {
          from_id: cities[trip['from']],
          to_id: cities[trip['to']],
          bus_id: buses[bus_key][:id],
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents']
        }
        if i >= BATCH_SIZE
          Trip.import(trips)
          trips = []
        end
        i += 1
      end
      Trip.import(trips)
      buses.each do |_key, values|
        BusesService.import(values[:services].map { |service_id| { bus_id: values[:id], service_id: service_id } })
      end
    end
  end
end
