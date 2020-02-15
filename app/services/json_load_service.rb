# frozen_string_literal: true

class JsonLoadService
  def self.call(file_name)
    json = JSON.parse(File.read("fixtures/#{file_name}"))

    # dictionary - forward!
    services = Set.new
    cities = Set.new
    buses = Set.new



    json.each do |trip|
      trip['bus']['services'].each { |name| services << { name: name } }
      cities << { name: trip['to'] }
      cities << { name: trip['from'] }
      buses  << { number: trip['bus']['number'], model: trip['bus']['model'] }
    end

    Service.import services.to_a
    City.import cities.to_a
    Bus.import buses.to_a

    cities_dictionary = City.all.load
    buses_dictionary = Bus.all.load

    trips = Set.new
    json.each do |trip|
      from_id = cities_dictionary.find_by(name: trip['from']).id
      to_id =   cities_dictionary.find_by(name: trip['to']).id
      bus_id =  buses_dictionary.find_by(number: trip['bus']['number']).id
      trips << {
        from_id: from_id,
        to_id: to_id,
        bus_id: bus_id,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
    end
    Trip.import trips.to_a
  end
end