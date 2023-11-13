# frozen_string_literal: true

class DatabaseReloader
  attr_accessor :cities, :buses, :services, :buses_services, :trips, :json, :batch_size

  def initialize(file_name, batch_size = 1_000)
    @cities = {}
    @buses = {}
    @services = {}
    @buses_services = {}
    @trips = []
    @json = JSON.parse(File.read(file_name))
    @batch_size = batch_size
  end

  def call
    City.delete_all
    Bus.delete_all
    Service.delete_all
    BusesService.delete_all
    Trip.delete_all

    # services are known in advance and won't change during JSON parse
    services = Service::SERVICES.map.with_index { |service, index| { id: index + 1, name: service } }
    Service.import(%i[id name], services, validate: false)
    services = services.to_h { |service| [service[:name], service[:id]] }

    ActiveRecord::Base.transaction do
      json.each do |trip|
        cities[trip['from']] ||= City.find_or_create_by(name: trip['from'])
        cities[trip['to']] ||= City.find_or_create_by(name: trip['to'])
        bus_number = trip['bus']['number']
        buses[bus_number] ||= Bus.find_or_create_by(number: bus_number, model: trip['bus']['model'])

        trip['bus']['services'].each do |service|
          service_id = services[service]
          buses_services["#{buses[bus_number]}-#{service_id}"] ||=
            BusesService.find_or_create_by(bus: buses[bus_number], service_id: service_id)
        end

        trips << Trip.new(
          from: cities[trip['from']],
          to: cities[trip['to']],
          bus: buses[bus_number],
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents']
        )

        # bulk import each 1000 or batch_size trip records
        if trips.size == batch_size
          Trip.import!(trips)
          self.trips = []
        end
      end
      # import last accumulated batch after JSON is read
      Trip.import!(trips) if trips.present?
    end
  end
end
