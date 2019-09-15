# frozen_string_literal: true

class JsonFileToDbProcessor
  attr_accessor :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    json = JSON.parse(File.read(@file_name))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')
    end

    # cities
    cities = {}
    ActiveRecord::Base.transaction do
      json.each do |trip|
        cities[trip['from']] = { name: trip['from'] }
        cities[trip['to']] = { name: trip['to'] }
      end
      City.import cities.values, on_duplicate_key_ignore: true
    end
    city_hash = City.all.pluck(:name, :id).to_h


    # services
    services = {}
    ActiveRecord::Base.transaction do
      json.each do |trip|
        trip['bus']['services'].each do |service|
          services[service] = {name: service}
        end
      end
      Service.import services.values, on_duplicate_key_ignore: true
    end
    services_hash = Service.all.pluck(:name, :id).to_h


    # buses
    buses = {}
    ActiveRecord::Base.transaction do
      json.each do |trip|
        buses[trip['bus']['number']] = {number: trip['bus']['number'], model: trip['bus']['model']}
      end
      Bus.import buses.values, on_duplicate_key_ignore: true
    end
    buses_hash = Bus.all.pluck(:number, :id).to_h


    # buses_services
    buses_services = {}
    ActiveRecord::Base.transaction do
      json.each do |trip|
        trip['bus']['services'].each do |service|
          buses_services["#{trip['bus']['number']}-#{service}"] = {
            bus_id: buses_hash[trip['bus']['number']],
            service_id: services_hash[service]
          }
        end
      end
      BusesService.import buses_services.values, on_duplicate_key_ignore: true
    end

    # trips
    records = []
    ActiveRecord::Base.transaction do
      json.each do |trip|
        from_id = city_hash[trip['from']]
        to_id = city_hash[trip['to']]

        records << {
            from_id: from_id,
            to_id: to_id,
            bus_id: buses_hash[trip['bus']['number']],
            start_time: trip['start_time'],
            duration_minutes: trip['duration_minutes'],
            price_cents: trip['price_cents'],
        }
        if records.count > 50
          Trip.import records, on_duplicate_key_ignore: true
          records = []
        end
      end

      Trip.import records
    end

  end
end