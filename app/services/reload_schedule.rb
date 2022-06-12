class ReloadSchedule
  def self.call(file_name:, gc_disabled: false)
    new.call(file_name: file_name, gc_disabled: gc_disabled)
  end

  def call(file_name:, gc_disabled:)
    GC.disable if gc_disabled
    @last_service_id = 0

    json = JSON.parse(File.read(file_name))

    ActiveRecord::Base.transaction do
      clear_db
      import_from_json(json)
    end
  end

  private

  def clear_db
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusService.delete_all
  end

  def import_from_json(json)
    city_names = Set.new
    cities_hashes = []
    service_names = Set.new
    service_hashes = []
    bus_numbers = Set.new
    bus_hashes = []
    trip_hashes = []
    bus_services = Set.new
    json.each_with_index do |trip, i|
      unless city_names.include? trip['from']
        city_names << trip['from']
        @from_id = i + 1
        from_hash = {id: @from_id, name: trip['from']}
        cities_hashes << from_hash
      end
      unless city_names.include? trip['to']
        city_names << trip['to']
        @to_id = i + 2
        to_hash = {id: @to_id, name: trip['to']}
        cities_hashes << to_hash
      end

      unless @from_id
        hash = cities_hashes.find { |hash| hash[:name] == trip['from'] }
        @from_id = hash[:id]
      end

      unless @to_id
        hash = cities_hashes.find { |hash| hash[:name] == trip['to'] }
        @to_id = hash[:id]
      end

      service_ids = []
      services = trip['bus']['services']
      services.each do |service|
        if !service_names.include? service
          @last_service_id += 1
          service_hashes << {id: @last_service_id, name: service}
          service_ids << @last_service_id
          service_names << service
        else
          hash = service_hashes.find { |hash| hash[:name] == service }
          service_ids << hash[:id]
        end
      end

      bus_number = trip['bus']['number']
      if !bus_numbers.include? bus_number
        @bus_id = i + 1
        bus_hashes << {id: @bus_id, number: bus_number, model: trip['bus']['model']}
        bus_numbers << bus_number
      else
        bus_hash = bus_hashes.find { |hash| hash[:number] == bus_number }
        @bus_id = bus_hash[:id]
      end


      service_ids.each do |service_id|
        bus_services << {bus_id: @bus_id, service_id: service_id}
      end

      trip_hash = {
        from_id: @from_id,
        to_id: @to_id,
        bus_id: @bus_id,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
      trip_hashes << trip_hash
    end
    City.insert_all(cities_hashes)
    Service.insert_all(service_hashes)
    Bus.insert_all(bus_hashes)
    Trip.insert_all(trip_hashes)
    BusService.insert_all(bus_services)
  end
end