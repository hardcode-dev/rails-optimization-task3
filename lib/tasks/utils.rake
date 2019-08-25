# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  t = Time.now
  FROM = "{\"from\":"
  ActiveRecord::Base.transaction do
    Bus.delete_all
    City.delete_all
    Trip.delete_all
    BusService.delete_all
    @buses = {}
    @trips = []
    @cities = {}
    City.all.each { |c| @cities[c.name] = c.id }
    File.open(args.file_name).each(FROM) do |raw_line|
      next if raw_line.size <= 10
      hash = MultiJson.load(FROM + raw_line[0..(raw_line.chomp.last == "]" ? -2 : -10)], symbolize_keys: true)
      city_from_id, city_to_id = city_id(hash[:from]), city_id(hash[:to])

      bus = if @buses[hash[:bus][:number].to_i].present?
              @buses[hash[:bus][:number].to_i]
            else
              bus = Bus.create(number: hash[:bus][:number].to_i, model: Bus::MODELS.index(hash[:bus][:model]))
              @buses[hash[:bus][:number].to_i] = bus
              bus
            end
      create_buses_services(hash[:bus][:services].map { |s| "(#{bus.id}, #{BusService::SERVICES.index(s)})" }) if hash[:bus][:services].present?
      @trips << "(#{city_from_id}, #{city_to_id}, #{bus.id}, '#{hash[:start_time]}', #{hash[:price_cents]}, #{hash[:duration_minutes]})"
    end
    create_trips(@trips)
  end
  puts "-------------------------------------------- each #{Time.now - t}" # 141.926986
end

def city_id(name)
  if @cities.include? name
    @cities[name]
  else
    city = City.create(name: name)
    @cities[name] = city.id
    city.id
  end
end

def create_buses_services(bus_services)
  BusService.connection.execute <<-SQL
    INSERT INTO bus_services (bus_id, service_id)
    VALUES #{bus_services.join(',')};
  SQL
end

def create_trips(trips)
  Trip.connection.execute <<-SQL
    INSERT INTO trips (from_id, to_id, bus_id, start_time, price_cents, duration_minutes)
    VALUES #{trips.join(',')};
  SQL
end
