# frozen_string_literal: true

require 'benchmark'
require 'oj'
require 'ruby-progressbar'

class JsonLoader
  TOTAL_TRIPS = 10_000_000

  def initialize
    @cities = {}
    @buses = {}
    @services = {}

    @bus_services = []
  end

  def perform(filename)
    time = Benchmark.realtime do
      load_from_file(filename)
    end

    puts "Finished in #{time.round(5)}"
  end

  private

  def load_from_file(filename)
    trips_imported = 0
    progressbar = ProgressBar.create(
      total: 100,
      format: '%a, %J, %E %B' # elapsed time, % complete, estimate, bar
    )
    step = TOTAL_TRIPS / 100

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      Service::SERVICES.each do |name|
        s = Service.create(name: name)
        @services[name] = s.id
      end

      trips_command =
        "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"

      conn = ActiveRecord::Base.connection.raw_connection
      conn.copy_data(trips_command) do
        File.open(filename) do |ff|
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
              if nesting == 0 # если закончился объект уровня trip, парсим и импортируем его
                trip = Oj.load(str)
                import_trip(conn, trip)

                trips_imported += 1
                if trips_imported % step == 0
                  progressbar.increment
                end

                str = +""
              end
            when nesting >= 1
              str << ch
            end
          end
        end
      end

      import_cities
      import_buses
      import_bus_services
    end
  end

  def import_trip(conn, trip)
    from_id = @cities[trip['from']]

    if !from_id
      from_id = @cities.size + 1
      @cities[trip['from']] = from_id
    end

    to_id = @cities[trip['to']]

    if !to_id
      to_id = @cities.size + 1
      @cities[trip['to']] = to_id
    end

    bus_data = trip['bus']
    bus = @buses[[bus_data['model'], bus_data['number']]] ||= {}
    if bus.empty?
      bus[:id] = @buses.size + 1
      bus[:model] = bus_data['model']
      bus[:number] = bus_data['number']

      service_ids = []
      bus_data['services'].each do |service|
        @bus_services << { bus_id: bus[:id], service_id: @services[service] }
      end
    end
    bus_id = bus[:id]

    # стримим подготовленный чанк данных в postgres
    conn.put_copy_data("#{from_id};#{to_id};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus_id}\n")
  end

  def import_cities
    res = @cities.map do |name, id|
      { id: id, name: name }
    end

    City.import(res)
  end

  def import_buses
    res = @buses.map do |_, data|
      { id: data[:id], model: data[:model], number: data[:number] }
    end

    Bus.import(res)
  end

  def import_bus_services
    sql = []

    @bus_services.each do |data|
      sql << "(#{data[:bus_id]}, #{data[:service_id]})"
    end
    
    ActiveRecord::Base.connection.execute("INSERT INTO buses_services (bus_id, service_id) VALUES #{sql.join(',')}")
  end
end
