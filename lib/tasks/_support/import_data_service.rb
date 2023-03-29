class ImportDataService
  BATCH_SIZE = 1000

  def initialize(file_name)
    @file_name = file_name
    @grouped_cities = {}
    @grouped_buses = {}
    @grouped_services = nil
    @trips = []
  end

  def call
    json = Oj.load(File.read(file_name))

    ActiveRecord::Base.transaction do
      delete_data!
      import_services!

      json.each_slice(BATCH_SIZE) do |batch|
        batch.each do |trip|
          from = prepare_city(trip['from'])
          to = prepare_city(trip['to'])
          bus = prepare_bus(trip['bus'])

          trips << Trip.new(
            from: from,
            to: to,
            bus: bus,
            start_time: trip['start_time'],
            duration_minutes: trip['duration_minutes'],
            price_cents: trip['price_cents'],
          )
        end
      end

      City.import! grouped_cities.values
      Bus.import! grouped_buses.values, recursive: true
      Trip.import! trips
    end
  end

  private

  attr_reader :file_name, :grouped_cities, :grouped_buses, :trips, :grouped_services

  def delete_data!
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusesService.delete_all
  end

  def import_services!
    services = Service::SERVICES.map { |service_name| Service.new(name: service_name) }
    Service.import! services

    @grouped_services = services.group_by(&:name).transform_values!(&:first)
  end

  def prepare_city(name)
    grouped_cities[name] ||= City.new(name: name)

    grouped_cities[name]
  end

  def prepare_bus(bus_data)
    bus_key = "#{bus_data['number']}_#{bus_data['model']}"
    services = bus_data['services'].map { |s| grouped_services[s] }

    grouped_buses[bus_key] ||= Bus.new(number: bus_data['number'], model: bus_data['model'])
    grouped_buses[bus_key].services.append(services)

    grouped_buses[bus_key]
  end
end
