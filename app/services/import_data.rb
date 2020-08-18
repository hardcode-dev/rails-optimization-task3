class ImportData
  attr_reader :file_name, :cities, :buses, :services, :buses_services

  def initialize(file_name)
    @file_name = file_name
    @cities = {}
    @buses = {}
    @services = {}
    @buses_services = {}
  end

  def exec
    ActiveRecord::Base.transaction do
      trips_command =
        "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"

      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute("delete from buses_services;")
      ActiveRecord::Base.connection.reset_pk_sequence!("cities")
      ActiveRecord::Base.connection.reset_pk_sequence!("buses")
      ActiveRecord::Base.connection.reset_pk_sequence!("services")

      connection.copy_data trips_command do
        File.open(file_name) do |ff|
          nesting = 0
          str = +""

          while !ff.eof?
            ch = ff.read(1) # читаем по одному символу
            case
            when ch == "{" # начинается объект, повышается вложенность
              nesting += 1
              str << ch
            when ch == "}" # заканчивается объект, понижается вложенность
              nesting -= 1
              str << ch
              if nesting == 0 # если закончился объкет уровня trip, парсим и импортируем его
                trip = Oj.load(str)
                import(trip)
                # progress_bar.increment
                str = +""
              end
            when nesting >= 1
              str << ch
            end
          end
        end
      end

      City.import @cities.map { |el| { name: el[0] } }
      Service.import @services.map { |el| { name: el[0] } }
      Bus.import @buses.map { |hash_key, el| { number: hash_key, model: el[:model] } }
      BusService.import @buses_services.map { |el| { service_id: el[0], bus_id: el[1] } }
    end
  end

  private

  def parse_id(dict, hash_key)
    to_id = dict[hash_key]
    if !to_id
      to_id = dict.size + 1
      dict[hash_key] = to_id
    end
    to_id
  end

  def bus_number(trip)
    find_bus = buses[trip["number"]]
    if !find_bus
      bus_id = buses.size + 1
      find_bus = buses[trip["number"]] = {
        id: bus_id,
        model: trip["model"],
      }
      trip["services"].each do |service|
        service_id = buses_services.size + 1
        buses_services[service_id] = bus_id
        parse_id services, service
      end
    end
    find_bus
  end

  def import(trip)
    from_id = parse_id(cities, trip["from"])
    to_id = parse_id(cities, trip["to"])
    bus = bus_number(trip["bus"])

    # стримим подготовленный чанк данных в postgres
    connection.put_copy_data("#{from_id};#{to_id};#{trip["start_time"]};#{trip["duration_minutes"]};#{trip["price_cents"]};#{bus[:id]}\n")
  end

  def connection
    @connection ||= ActiveRecord::Base.connection.raw_connection
  end
end
