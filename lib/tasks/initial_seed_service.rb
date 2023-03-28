# frozen_string_literal: true

require 'oj'
require 'fast_jsonparser'

class InitialSeedService
  class << self
    def call(file_name)
      prepare_db
      data = parsed_data(file_name)
      persist(data)
    end

    def prepare_db
      Trip.delete_all
      City.delete_all
      Bus.delete_all
      Service.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')
    end

    def parsed_data(file_name)
      file_content = File.read(file_name)
      # JSON.parse(file_content)
      # Oj.load(file_content, symbolize_keys: false)
      FastJsonparser.parse(file_content, symbolize_keys: false)
    end

    def persist(data)
      cities = {}
      buses = {}
      services = {}
      trips = []
      buses_services = {}

      ActiveRecord::Base.transaction do
        data.each do |trip|
          cities[trip['from']] ||= City.create!(name: trip['from'])
          cities[trip['to']] ||= City.create!(name: trip['to'])

          bus_number = trip['bus']['number']

          buses[bus_number] ||= Bus.create!(
            number: bus_number,
            model: trip['bus']['model']
          )

          trip['bus']['services'].each do |service|
            services[service] ||= Service.create!(name: service)
            key = [bus_number, service].join('_')
            buses_services[key] ||= BusesService.create!(bus: buses[bus_number], service: services[service])
          end

          trips << {
            from_id: cities[trip['from']].id,
            to_id: cities[trip['to']].id,
            bus_id: buses[bus_number].id,
            start_time: trip['start_time'],
            duration_minutes: trip['duration_minutes'],
            price_cents: trip['price_cents']
          }
        end

        Trip.import!(trips)
      end
    end
  end
end
