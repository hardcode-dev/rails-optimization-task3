class Reloader
  def self.call(file_name)
    new(file_name).call
  end

  def initialize(file_name)
    @file_name = file_name
    @json = JSON.parse(File.read(file_name))
  end

  def call
    ActiveRecord::Base.transaction do
      clear_tables
      collect_and_create_data
    end
  end

  private

  attr_reader :file_name, :json

  def clear_tables
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('DELETE FROM buses_services')
  end

  def collect_and_create_data
    collected_data = collect_data
    created_records = create_main_records(collected_data)
    create_associated_records(created_records)
  end

  def collect_data
    {
      cities: Set.new,
      buses: [],
      services: Set.new
    }.tap do |data|
      json.each do |trip|
        data[:cities] << trip['from']
        data[:cities] << trip['to']
        data[:services].merge(trip['bus']['services'])
        data[:buses] << {
          number: trip['bus']['number'],
          model: trip['bus']['model']
        }
      end
    end
  end

  def create_main_records(collected_data)
    {
      cities: create_cities(collected_data[:cities]),
      services: create_services(collected_data[:services]),
      buses: create_buses(collected_data[:buses])
    }
  end

  def create_cities(cities)
    City.insert_all(
      cities.map { |name| { name: name } },
      returning: [:id, :name]
    ).index_by { |city| city['name'] }
  end

  def create_services(services)
    Service.insert_all(
      services.map { |name| { name: name } },
      returning: [:id, :name]
    ).index_by { |service| service['name'] }
  end

  def create_buses(buses)
    Bus.insert_all(
      buses.uniq { |bus| bus[:number] },
      returning: [:id, :number]
    ).index_by { |bus| bus['number'] }
  end

  def create_associated_records(created_records)
    buses_services_data = []
    trips_data = []

    json.each do |trip|
      bus_id = created_records[:buses][trip['bus']['number']]['id']

      collect_buses_services_data(
        buses_services_data,
        bus_id,
        trip['bus']['services'],
        created_records[:services]
      )

      collect_trips_data(
        trips_data,
        trip,
        bus_id,
        created_records[:cities]
      )
    end

    create_buses_services(buses_services_data)
    create_trips(trips_data)
  end

  def collect_buses_services_data(data, bus_id, services, services_records)
    services.each do |service_name|
      data << {
        bus_id: bus_id,
        service_id: services_records[service_name]['id']
      }
    end
  end

  def collect_trips_data(data, trip, bus_id, cities)
    data << {
      from_id: cities[trip['from']]['id'],
      to_id: cities[trip['to']]['id'],
      bus_id: bus_id,
      start_time: trip['start_time'],
      duration_minutes: trip['duration_minutes'],
      price_cents: trip['price_cents']
    }
  end

  def create_buses_services(data)
    return if data.empty?

    values = data.uniq.map { |r| "(#{r[:bus_id]}, #{r[:service_id]})" }.join(', ')
    ActiveRecord::Base.connection.execute(
      "INSERT INTO buses_services (bus_id, service_id) VALUES #{values}"
    )
  end

  def create_trips(data)
    Trip.insert_all!(data)
  end
end
