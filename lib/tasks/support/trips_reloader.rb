class TripsReloader
  attr_accessor :json, :cities, :services, :buses, :buses_services, :trips

  def initialize(json)
    @json           = json
    @cities         = Set.new
    @services       = Set.new
    @buses          = Set.new
    @buses_services = Set.new
    @trips          = Set.new
  end

  def call
    clear_database
    parse_json
    import_records
  end

  private

  def clear_database
    City.delete_all
    Service.delete_all
    Bus.delete_all
    BusesService.delete_all
    Trip.delete_all
  end

  def parse_json
    json.each do |trip|
      trips << {
        from_id:          find_or_add_object(cities, trip['from'])[:id],
        to_id:            find_or_add_object(cities, trip['to'])[:id],
        bus_id:           update_or_add_bus(trip['bus'])[:id],
        start_time:       trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents:      trip['price_cents']
      }
    end
  end

  def import_records
    City.insert_all!(cities)
    Service.insert_all!(services)
    Bus.insert_all!(buses)
    BusesService.insert_all!(buses_services)
    Trip.insert_all!(trips)
  end

  def find_or_add_object(array, value, key = :name)
    array.find { |object| object[key] == value }.presence || add_object(array, value, key)
  end

  def add_object(array, value, key)
    new_object = {
      id: array.size + 1,
      key => value,
    }

    array << new_object

    new_object
  end

  def update_or_add_bus(bus_attributes)
    bus = find_or_add_object(buses, bus_attributes['number'], :number)
    bus['model'] = bus_attributes['model']

    bus_attributes['services'].map do |service|
      buses_services << {
        bus_id: bus[:id],
        service_id: find_or_add_object(services, service)[:id],
      }
    end

    bus
  end
end
