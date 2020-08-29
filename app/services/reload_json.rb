class ReloadJson
  def call(file_name, without_db_queries = false)
    json = JSON.parse(File.read(file_name))

    # @cities = []
    # @services = []
    # @buses = []

    @cities_columns = [:id, :name]
    @cities_values = []
    @cities_index = 0
    @buses_columns = [:id, :number, :model]
    @buses_values = []
    @buses_index = 0
    @services_columns = [:id, :name]
    @services_values = []
    @services_index = 0
    @buses_services_columns = [:id, :bus_id, :service_id]
    @buses_services_values = []
    @buses_services_index = 0
    @trips_columns = [:id, :from_id, :to_id, :start_time, :duration_minutes, :price_cents, :bus_id]
    @trips_values = []
    @trips_index = 0

    json.each do |trip|
      from = find_or_build_city(trip['from'])
      to = find_or_build_city(trip['to'])
      bus = find_or_build_bus(trip['bus']['number'], trip['bus']['model'])
      trip['bus']['services'].each { |service_name| find_or_build_service(service_name, bus[0]) }
      @trips_values << [@trips_index += 1, from[0], to[0], trip['start_time'],
                        trip['duration_minutes'], trip['price_cents'], bus[0]]
    end

    return if without_db_queries

    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute('delete from cities;
                                             delete from buses;
                                             delete from services;
                                             delete from trips;
                                             delete from buses_services;')
      City.import @cities_columns, @cities_values
      Bus.import @buses_columns, @buses_values
      Service.import @services_columns, @services_values
      BusesServices.import @buses_services_columns, @buses_services_values
      Trip.import @trips_columns, @trips_values
    end
  end

  private

  def find_or_build_city(city_name)
    city = @cities_values.find { |c| c[1] == city_name } || build_city(city_name)
  end

  def build_city(city_name)
    @cities_values << city = [@cities_index += 1, city_name]
    city
  end

  def find_or_build_bus(number, model)
    @buses_values.find { |b| b[1] == number } || build_bus(number, model)
  end

  def build_bus(number, model)
    @buses_values << bus = [@buses_index += 1, number, model]
    bus
  end

  def find_or_build_service(service_name, bus_id)
    @services_values.find { |b| b[1] == service_name } || build_service_and_buses_relation(service_name, bus_id)
  end

  def build_service_and_buses_relation(service_name, bus_id)
    service_id = @services_index += 1
    @services_values << service = [service_id, service_name]
    build_buse_service_relation(bus_id, service_id)
    service
  end

  def build_buse_service_relation(bus_id, service_id)
    @buses_services_values << [@buses_services_index += 1, bus_id, service_id]
  end
end
