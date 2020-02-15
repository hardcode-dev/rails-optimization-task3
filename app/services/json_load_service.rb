# frozen_string_literal: true

class JsonLoadService
  def self.call(file_name)
    puts Time.now
    json = Oj.load(File.read("fixtures/#{file_name}"))

    # dictionary - forward!
    cities = Set.new
    buses = Set.new

    json.each do |trip|
      cities << { name: trip['to'] }
      cities << { name: trip['from'] }

      buses  << {
                  number: trip['bus']['number'],
                  model: trip['bus']['model'],
                  services: trip['bus']['services'].map {|name| Bus::SERVICES.index(name) }
                }
    end

    City.import cities.to_a
    Bus.import buses.to_a

    cities_dictionary = City.all.load
    buses_dictionary = Bus.all.load

    trips = Set.new
    json.each do |trip|
      from = cities_dictionary.detect { |city| city.name == trip['from'] }
      to =   cities_dictionary.detect { |city| city.name == trip['to'] }
      bus =  buses_dictionary.detect { |bus| trip['bus']['number'] == bus.number }

      trips << {
        from_id: from.id,
        to_id: to.id,
        bus_id: bus.id,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
    end

    Trip.import trips.to_a, validate: false, no_returning: true
    puts Time.now
  end
end