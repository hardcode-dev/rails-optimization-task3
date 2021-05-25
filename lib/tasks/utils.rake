task :reload_json, [:file_name] => :environment do |_task, args|
  trips = []
  cities = {}
  buses = {}
  services = {}
  bus_services = []

  file_stream = File.new(args.file_name, 'r')

  ActiveRecord::Base.connection.execute <<~SQL
    delete from cities;
    delete from buses;
    delete from services;
    delete from trips;
    delete from buses_services;
  SQL

  file_stream.each_with_index('},{') do |line, index|
    if index.zero?
      line.delete_prefix!('[')
    else
      line.prepend('{')
    end

    line.delete_suffix!(']')
    line.delete_suffix!("]\n")
    line.delete_suffix!(',{')

    trip = JSON(line)

    cities[trip['from']] ||= City.find_or_create_by(name: trip['from'])
    cities[trip['to']] ||= City.find_or_create_by(name: trip['to'])
    buses[trip['bus']['number']] ||= Bus.find_or_create_by(
      number: trip['bus']['number'],
      model: trip['bus']['model']
    )

    trip['bus']['services'].each do |service|
      services[service] ||= Service.find_or_create_by(name: service)

      bus_services << {
        bus_id: buses[trip['bus']['number']].id,
        service_id: services[service].id
      }
    end

    trips << {
      from_id: cities[trip['from']].id,
      to_id: cities[trip['to']].id,
      bus_id: buses[trip['bus']['number']].id,
      start_time: trip['start_time'],
      duration_minutes: trip['duration_minutes'],
      price_cents: trip['price_cents']
    }

    if (index % 10_000).zero? && index != 0
      BusesServices.insert_all(bus_services.uniq)
      Trip.insert_all(trips)

      trips = []
      bus_services = []
      print "#{index}\r"
    else
      Trip.insert_all(trips) if file_stream.eof?

      next
    end
  end
end
