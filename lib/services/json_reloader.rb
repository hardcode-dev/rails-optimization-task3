# frozen_string_literal: true

class JsonReloader
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    json = JSON.parse(File.read(file_name))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      buses = {}
      cities = {}
      services = {}
      buses_services_records = []
      trip_records = []

      json.each do |trip|
        from = find_or_add_record!(key: trip['from'], result_hash: cities) { |id| Hash[id: id, name: trip['from']] }
        to = find_or_add_record!(key: trip['to'], result_hash: cities) { |id| Hash[id: id, name: trip['to']] }
        bus_key = "#{trip.dig('bus','number')}#{trip.dig('bus','model')}"
        bus = find_or_add_record!(key: bus_key, result_hash: buses) do |id|
          source = trip['bus']
          bus_record = {
            id: id,
            number: source['number'],
            model: source['model']
          }

          source['services'].each do |service|
            service = find_or_add_record!(key: service, result_hash: services) { |id| Hash[id: id, name: service] }
            buses_services_records << [bus_record[:id], service[:id]]
          end

          bus_record
        end

        trip_record = {
          from_id: from[:id],
          to_id: to[:id],
          bus_id: bus[:id],
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents']
        }

        trip_records << trip_record
      end

      Service.import services.values, validate: false
      Bus.import buses.values, validate: false

      ActiveRecord::Base.connection.execute(<<~SQL)
        INSERT INTO buses_services (bus_id, service_id) VALUES
        #{buses_services_records.map { |bus_id, service_id| "(#{bus_id},#{service_id})" }.join(', ')}
      SQL

      City.import cities.values, validate: false
      Trip.import trip_records, validate: false
    end
  end

  def find_or_add_record!(key:, result_hash:)
    record = result_hash[key]
    return record if record

    id = result_hash.size + 1
    result_hash[key] = yield(id)
  end
end
