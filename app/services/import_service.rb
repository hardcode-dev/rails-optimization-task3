require 'progress_bar'

class ImportService
  attr_reader :bar, :cities, :file_name, :connection, :buses_services_values, :services, :buses

  def initialize(file_name)
    @file_name = file_name
    @bar = ProgressBar.new(1000000)
    @connection = PG::Connection.open(:dbname => 'task-4_development', port: 5432, user: ENV['PG_USERNAME'], password: ENV['PG_PASSWORD'])

    @cities = {}
    @buses = {}
    @buses_services_values = []
    @services = []

    import_services
  end

  def call
    read_file
    import_cities
    binding.pry
    import_buses
    ActiveRecord::Base.connection.execute('INSERT INTO buses_services ("bus_id","service_id") VALUES ' << buses_services_values.uniq.join(',') )
  end

  private

  def import_cities
    cities_array_values = cities.keys.map { |name| "('" << name << "')" }.join(',')
    ActiveRecord::Base.connection.execute('INSERT INTO cities ("name") VALUES ' << cities_array_values )
  end

  def import_buses
    buses_array_values = buses.keys.map { |data| "('" << data[0] << "','" << data[1] << "')" }.join(',')
    ActiveRecord::Base.connection.execute('INSERT INTO buses ("number","model") VALUES ' << buses_array_values )
  end

  def import_services
    Service.import(['name'], Service::SERVICES.map { |name| Service.new(name: name) })
    @services = Service.all
  end

  def record_bus_services(bus_id, bus_services)
    bus_services.each do |service|
      str = ''
      str << "('" << bus_id.to_s << "','" << services.detect { |s| s.name == service }.id.to_s << "')"
      buses_services_values << str
    end
  end

  def import(trip)
    from_id = cities[trip['from']]
    to_id = cities[trip['to']]
    bus_id = buses[[trip['bus']['number'], trip['bus']['model']]]

    unless from_id
      from_id = cities.size + 1
      cities[trip['from']] = from_id
    end

    unless to_id
      to_id = cities.size + 1
      cities[trip['to']] = to_id
    end

    unless bus_id
      bus_id = buses.size + 1
      buses[[trip['bus']['number'], trip['bus']['model']]] = bus_id
    end

    record_bus_services(bus_id, trip['bus']['services'])

    # стримим подготовленный чанк данных в postgres
    connection.put_copy_data("#{from_id};#{to_id};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus_id}\n")
  end

  def connection
    @connection ||= ActiveRecord::Base.connection.raw_connection
  end

  def read_file
    ActiveRecord::Base.transaction do
      trips_command =
        "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';';"

      connection.copy_data trips_command do
        File.open(file_name) do |ff|
          nesting = 0
          str = +""

          while !ff.eof?
            ch = ff.read(1) # читаем по одному символу
            case
            when ch == '{' # начинается объект, повышается вложенность
              nesting += 1
              str << ch
            when ch == '}' # заканчивается объект, понижается вложенность
              nesting -= 1
              str << ch
              if nesting == 0 # если закончился объкет уровня trip, парсим и импортируем его
                trip = Oj.load(str)
                import(trip)
                bar.increment!
                str = +""
              end
            when nesting >= 1
              str << ch
            end
          end
          ff.close
        end
      end
    end
  end
end
