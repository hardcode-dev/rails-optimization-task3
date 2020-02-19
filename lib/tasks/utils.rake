# frozen_string_literal: true
task :reload_json, [:file_name] => :environment do |_task, args|
  json = Oj.load(File.read(args.file_name))

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    BusesService.delete_all
    Trip.delete_all

    Service.import Service::SERVICES.map{ |service| Service.new(name: service) }
    cities = Set.new
    buses = Set.new
    trips = Set.new
    buses_services = Set.new

    json.each do |trip|
      cities << {name: trip['from']}
      cities << {name: trip['to']}
      buses << {number: trip['bus']['number'], model: trip['bus']['model']}
    end

    City.import cities.to_a
    Bus.import buses.to_a

    cities_name_id_hash = City.all.map{ |c| [c.name, c.id] }.to_h
    buses_number_id_hash = Bus.select(:id, :number).map{ |b| [b.number, b.id] }.to_h
    services_name_id_hash = Service.all.map{ |s| [s.name, s.id] }.to_h

    json.each do |trip|
      bus_id = buses_number_id_hash[trip['bus']['number']]
      trip['bus']['services'].each do |service|
        service_id = services_name_id_hash[service]
        buses_services << {bus_id: bus_id, service_id: service_id}
      end

      trips << {
        from_id: cities_name_id_hash[trip['from']],
        to_id: cities_name_id_hash[trip['to']],
        bus_id: buses_number_id_hash[trip['bus']['number']],
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
    end

    Trip.import trips.to_a
    BusesService.import buses_services.to_a
  end
end
