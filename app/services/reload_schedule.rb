class ReloadSchedule
  def self.call(file_name:, gc_disabled: false)
    new.call(file_name: file_name, gc_disabled: gc_disabled)
  end

  def call(file_name:, gc_disabled:)
    GC.disable if gc_disabled

    @last_service_id = 0
    @last_city_id = 0
    @last_bus_id = 0

    trips = JSON.parse(File.read(file_name))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      BusService.delete_all
      Trip.delete_all

      save_entities(trips)
    end
  end

  private

  def save_entities(trips)
    @city_names = Set.new
    @cities_hashes = []

    @service_names = Set.new
    @bus_services = Set.new
    @service_hashes = []

    @bus_numbers = Set.new
    @bus_hashes = []

    trip_hashes = []

    trips.each_with_index do |trip, i|
      @from_id = fetch_city_id(trip['from'])
      @to_id = fetch_city_id(trip['to'])
      @bus_id = fetch_bus_id(trip)

      fetch_services(trip)

      trip_hashes << {
        from_id: @from_id,
        to_id: @to_id,
        bus_id: @bus_id,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
    end

    City.insert_all(@cities_hashes)
    Service.insert_all(@service_hashes)
    Bus.insert_all(@bus_hashes)
    Trip.insert_all(trip_hashes)
    BusService.insert_all(@bus_services)
  end

  def fetch_city_id(city_name)
    if @city_names.include? city_name
      hash = @cities_hashes.find { |hash| hash[:name] == city_name }
      hash[:id]
    else
      @last_city_id += 1
      @city_names << city_name
      @cities_hashes << { id: @last_city_id, name: city_name }
      @last_city_id
    end
  end

  def fetch_bus_id(trip)
    bus_number = trip['bus']['number']
    if @bus_numbers.include? bus_number
      hash = @bus_hashes.find { |hash| hash[:number] == bus_number }
      hash[:id]
    else
      @last_bus_id += 1
      @bus_hashes << {id: @last_bus_id, number: bus_number, model: trip['bus']['model']}
      @bus_numbers << bus_number
      @last_bus_id
    end
  end

  def fetch_services(trip)
    service_ids = []
    services = trip['bus']['services']
    services.each do |service|
      if @service_names.include? service
        hash = @service_hashes.find { |hash| hash[:name] == service }
        service_ids << hash[:id]
      else
        @last_service_id += 1
        @service_hashes << {id: @last_service_id, name: service}
        service_ids << @last_service_id
        @service_names << service
      end
    end

    service_ids.each do |service_id|
      @bus_services << {bus_id: @bus_id, service_id: service_id}
    end
  end
end