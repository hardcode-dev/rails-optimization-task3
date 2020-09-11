class ReloadJsonService
  attr_reader :file_name

  def initialize(args)
    @file_name = args[:file_name]
    @cities = {}
    @services = {}
    @buses = {}
    @bs = {}
  end

  def fetch_city(name)
    @cities[name] ||= City.create(name: name)
  end

  def fetch_service(name)
    @services[name] ||= Service.create(name: name)
  end

  def fetch_bus(bus)
    @buses[bus['number']] ||= Bus.new(number: bus['number'], model: bus['model'])
  end

  def fetch_bs(bus, service)
    @bs["#{bus.number}_#{service}"] ||= BusesServicesRelation.new(bus: bus, service: fetch_service(service))
  end

  def run
    json = Oj.load(File.read(file_name))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      BusesServicesRelation.delete_all

      batch = []
      bus_services_batch = []
      bus_batch = []

      json.each do |trip|
        from = fetch_city(trip['from'])
        to = fetch_city(trip['to'])
        bus = fetch_bus(trip['bus'])
        bus_batch << bus if bus.new_record?

        trip['bus']['services'].each do |service|
          bs = fetch_bs(bus, service)
          bus_services_batch << bs if bs.new_record?
        end

        batch << Trip.new(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        )

        if batch.size > 1000
          Bus.import(bus_batch.uniq)
          BusesServicesRelation.import(bus_services_batch.uniq)
          Trip.import batch
          bus_services_batch = []
          bus_batch = []
          batch = []
        end
      end

      Bus.import(bus_batch.uniq) if bus_batch.any?
      BusesServicesRelation.import(bus_services_batch.uniq) if bus_services_batch.any?
      Trip.import(batch) if batch.any?
    end
  end
end