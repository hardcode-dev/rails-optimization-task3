# frozen_string_literal: true

class ImportJSONService
  def self.perform(file_name)
    json = Oj.load(File.read(file_name))
    ActiveRecord::Base.transaction do
      clean_db
      buses = get_buses(json)
      cities = get_cities(json)
      services = get_services(json)
      buses_services = Set.new
      trips = []
      json.each do |trip|
        bus_id = buses[trip['bus']['number']]
        trip['bus']['services'].each { |service| buses_services << { bus_id: bus_id, service_id: services[service] } }
        trips << Trip.new(from_id: cities[trip['from']],
                          to_id: cities[trip['to']],
                          bus_id: bus_id,
                          start_time: trip['start_time'],
                          duration_minutes: trip['duration_minutes'],
                          price_cents: trip['price_cents'])
      end
      BusesService.import!(buses_services.to_a)
      Trip.import!(trips)
    end
  end
end

def get_buses(json)
  buses = json.pluck('bus').map! { |bus| { number: bus['number'], model: bus['model'] } }.uniq!
  Bus.import!(buses, returning: %i[id number model]).results.map { |b| b.first(2) }.to_h.invert
end

def get_cities(json)
  cities = json.pluck('from', 'to').flatten!.uniq!.map! { |name| { name: name } }
  City.import!(cities, returning: %i[id name]).results.to_h.invert
end

def get_services(json)
  services = json.pluck('bus').pluck('services').flatten!.uniq!.map! { |name| { name: name } }
  Service.import!(services, returning: %i[id name]).results.to_h.invert
end

def clean_db
  City.delete_all
  Bus.delete_all
  Service.delete_all
  Trip.delete_all
  BusesService.delete_all
end
