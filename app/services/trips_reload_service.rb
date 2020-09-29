class TripsReloadService
  def initialize(file_path)
    @file_path = file_path
    @cities = {}
    @buses = {}
    @services = {}
  end

  def run
    ActiveRecord::Base.transaction do
      clear_base
      import_file
    end
  end

  private

  def import_file
    json = JSON.parse(File.read(@file_path))

    json.each do |trip|
      from = find_city(trip['from'])
      to = find_city(trip['to'])
      bus = find_bus(trip['bus'])

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

  def find_city(name)
    unless @cities.key?(name)
      @cities[name] = City.find_or_create_by(name: name)
    end

    @cities[name]
  end


  def find_service(name)
    unless @services.key?(name)
      @services[name] = Service.find_or_create_by(name: name)
    end

    @services[name]
  end

  def find_bus(bus)
    number = bus['number']
    unless @buses.key?(number)
      @buses[number] = Bus.find_or_initialize_by(number: number)
      @buses[number].model = bus['model']

      services = []
      bus['services'].each do |service|
        s = find_service(service)
        services << s
      end
      @buses[number].services = services
      @buses[number].save
    end

    @buses[number]
  end

  def clear_base
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end
end
