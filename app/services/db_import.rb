module DbImport
  module_function

  def prepare
    City.clear
    Bus.clear
    Service.clear
    Trip.clear
    BusesServices.clear
  end

  def set
    Set.new
  end

  def import(filename = 'fixtures/large.json')
    json = Oj.load(File.read(File.join(Rails.root, filename.to_s)))

    ActiveRecord::Base.transaction do
      prepare # clear DB content

      uniq_cities = set
      uniq_buses = set

      services = Service::SERVICES.map { |i| Service.new(name: i) }

      Service.import services

      services_dictionary = services.each_with_object({}) { |e, a| a[e.name] = e }

      json.each do |trip|
        uniq_cities << { name: trip['to'] }
        uniq_cities << { name: trip['from'] }

        uniq_buses << {
          number: trip['bus']['number'],
          model: trip['bus']['model'],
          services: trip['bus']['services'].map { |name| services_dictionary[name].id }
        }
      end

      buses = []
      uniq_buses.to_a.map do |i|
        bus = Bus.new(number: i[:number], model: i[:model])
        i[:services].each { |j| bus.buses_services.build(service_id: j) }
        buses << bus
      end

      cities = []
      uniq_cities.to_a.map do |i|
        city = City.new(name: i[:name])
        cities << city
      end

      Bus.import buses
      BusesServices
        .import buses.map { |i| i.buses_services.map { |j| { service_id: j.service_id, bus_id: i.id } } }.flatten
      City.import cities

      trips = []
      json.each do |trip|
        trips << {
          from_id: cities.detect { |i| i.name == trip['from'] }.id,
          to_id: cities.detect { |i| i.name == trip['to'] }.id,
          bus_id: buses.detect { |i| trip['bus']['number'] == i.number }.id,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents']
        }
      end

      Trip.import trips, validate: false
    end
  end
end
