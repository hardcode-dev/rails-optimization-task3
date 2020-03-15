class DataLoader
  attr_accessor :cnt

  def initialize(file)
    Service.setup
    @cnt = DataParser.new(file)
  end

  def call
    @cnt.call
    setup_cities
    setup_buses
    setup_buses_services(cnt.buses_services)
    setup_trips(cnt.trips)
  end

  private

  def setup_cities
    City.import cnt.cities.to_a, validate: true
    @cities = model_to_hash(City, :name)
  end

  def setup_buses
    Bus.import cnt.buses.to_a, validate: true
    @buses = model_to_hash(Bus, :number)
  end

  def setup_buses_services(buses_services)
    buses_services = buses_services.to_a.each do |b_s|
      b_s['bus_id'] = @buses[b_s['bus_id']['number']]
    end
    BusesService.import buses_services, validate: true
  end

  def setup_trips(trips)
    trips.in_groups_of(10_000, false) do |group|
      group.each do |trip|
        trip['to_id'] = @cities[trip['to_id']['name']]
        trip['from_id'] = @cities[trip['from_id']['name']]
        trip['bus_id'] = @buses[trip['bus_id']['number']]
      end
      Trip.import group, validate: true
    end
  end

  def model_to_hash(klass, field)
    klass.all.map { |s| [s.send(field), s.id] }.to_h
  end
end
