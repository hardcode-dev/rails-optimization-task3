class ReloadJson
  def initialize(file_name = 'fixtures/large.json')
    @file_name = file_name
  end

  def call
    reload_json
  end

  private

  def reload_json
    json = Oj.load(File.read(@file_name))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      BusesService.delete_all

      # array of arrays for importing to db
      services = []

      # filling services data
      Service::SERVICES.each do |service|
        services << [service]
      end

      # hash for collecting unique elements
      cities = {}
      # array of arrays for importing to db
      buses = []

      json.each do |trip|
        # collecting unique cities
        cities[trip['from']] = nil
        cities[trip['to']] = nil
        # filling buses data
        buses << [trip['bus']['number'], trip['bus']['model']]
      end

      # importing (with previously preparing if necessary)
      Service.import [:name], services
      City.import [:name], cities.keys.inject(Array.new) { |arr, el| arr << [el] }
      Bus.import [:number, :model], buses.uniq!(&:first)

      # hashes for storing data of saved to database records
      service_id_by_name = {}
      city_id_by_name = {}
      bus_id_by_number = {}

      # filling these hashes
      Service.select { |record| service_id_by_name[record.name] = record.id }
      City.select { |record| city_id_by_name[record.name] = record.id }
      Bus.select { |record| bus_id_by_number[record.number] = record.id }

      # arrays of arrays for importing to database
      buses_services = []
      trips = []

      json.each do |trip|
        # getting id if bus number exists
        bus_id = bus_id_by_number.dig(trip['bus']['number'])

        trip['bus']['services'].each do |service|
          # getting id if service name exists
          service_id = service_id_by_name.dig(service)
          # if bus and service both exist then adding data to array
          buses_services << [bus_id, service_id] if bus_id && service_id
        end

        # getting ids if cities names exist
        from_id = city_id_by_name.dig(trip['from'])
        to_id = city_id_by_name.dig(trip['to'])

        # if all the cities and bus exist then adding data to array
        trips << [from_id, to_id, trip['start_time'], trip['duration_minutes'], trip['price_cents'], bus_id] if from_id && to_id && bus_id 
      end

      # importing buses_services and trips data to database
      BusesService.import [:bus_id, :service_id], buses_services.uniq!
      Trip.import [:from_id, :to_id, :start_time, :duration_minutes, :price_cents, :bus_id], trips
    end
  end
end
