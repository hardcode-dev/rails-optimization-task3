def insert_multiple(array)

end

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  time_point = Time.now
  json = JSON.parse(File.read(args.file_name))

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    # create cities
    cities_names = ['from', 'to'].map { |f| json.pluck(f) }.flatten.uniq
    sql = "INSERT INTO cities ( name ) VALUES #{cities_names.map { |n| "( '#{n}' )" }.join(', ') };"
    ActiveRecord::Base.connection.execute(sql)

    # create buses
    buses = json.map { |trip| [trip['bus']['number'], trip['bus']['model']] }.uniq
    sql = "INSERT INTO buses ( number, model ) VALUES #{buses.map { |b| "( '#{b[0]}', '#{b[1]}' )" }.join(', ') };"
    ActiveRecord::Base.connection.execute(sql)

    # create services
    services_names = json.map { |trip| trip['bus']['services'] }.flatten.uniq
    sql = "INSERT INTO services ( name ) VALUES #{services_names.map { |n| "( '#{n}' )" }.join(', ') };"
    ActiveRecord::Base.connection.execute(sql)

    # assign services to buses
    services_ids_by_name = Service.all.map { |s| [s.name, s.id] }.to_h
    buses_ids_by_number = Bus.all.map { |b| [b.number, b.id] }.to_h
    buses_services = []
    json.each do |trip|
      bus = trip['bus']
      bus_id = buses_ids_by_number[bus['number']]
      bus['services'].each do |service_name|
        service_id = services_ids_by_name[service_name]
        buses_services << [bus_id, service_id]
      end
    end
    sql = <<~HEREDOC
    INSERT INTO buses_services ( bus_id, service_id ) VALUES
    #{buses_services.map { |b_s| "( #{b_s[0]}, #{b_s[1]} )" }.join(', ') };
    HEREDOC
    ActiveRecord::Base.connection.execute(sql)

    # create trips
    cities_ids_by_name = City.all.map { |s| [s.name, s.id] }.to_h
    trips = json.map do |trip|
      {
        from_id: cities_ids_by_name[trip['from']],
        to_id: cities_ids_by_name[trip['to']],
        bus_id: buses_ids_by_number[trip['bus']['number']],
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
    end
    sql = <<~HEREDOC
    INSERT INTO trips ( from_id, to_id, start_time, duration_minutes, price_cents, bus_id ) VALUES
    #{trips.map { |trip| "( #{trip[:from_id]}, #{trip[:to_id]}, '#{trip[:start_time]}', #{trip[:duration_minutes]}, #{trip[:price_cents]}, #{trip[:bus_id]} )" }.join(', ') };
    HEREDOC
    ActiveRecord::Base.connection.execute(sql)
  end
  puts "Done! it took: #{Time.now - time_point} sec."
end
