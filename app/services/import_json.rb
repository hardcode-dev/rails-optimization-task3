class ImportJson
  attr_reader :json,
              :buses_services_list,
              :trips_list,
              :cities_mapping,
              :buses_list

  def initialize(file_path)
    @json = JSON.parse(File.read(file_path))
    @cities_mapping = {}
    @buses_services_list = Set.new
    @buses_list = Set.new
    @trips_list = []
  end

  def perform
    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      services_mapping = Service::SERVICES.map { |name| [name, Service.create(name: name).id] }.to_h

      json.each do |trip|
        from_id = find_or_create_city(trip['from'])
        to_id = find_or_create_city(trip['to'])

        buses_list.add({
          number: trip['bus']['number'],
          model:  trip['bus']['model']
        })

        trip['bus']['services'].each do |service_name|
          buses_services_list.add({
            bus_number: trip['bus']['number'],
            service_id: services_mapping[service_name]
          })
        end

        trips_list << {
          from_id:          from_id,
          to_id:            to_id,
          bus_number:       trip['bus']['number'],
          start_time:       trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents:      trip['price_cents'],
        }
      end

      Bus.import! buses_list.to_a
      BusesServices.import! buses_services_list.to_a
      Trip.import! trips_list
    end
  end

  private

  def find_or_create_city(name)
    return cities_mapping[name] if cities_mapping[name]

    cities_mapping[name] = City.create!(name: name).id
  end
end
