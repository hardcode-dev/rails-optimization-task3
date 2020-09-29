class TripsReloadService
  def initialize(file_path)
    @file_path = file_path
    @cities = {}
    @buses = {}
    @services = {}
  end

  def run
    ActiveRecord::Base.transaction do
      clear_base
      create_reference_data
      import_file_stream
    end
  end

  private

  def create_reference_data
    json = Oj.load(File.open(@file_path))

    json.each do |trip|
      find_city(trip['from'])
      find_city(trip['to'])
      find_bus(trip['bus'])
    end
  end

  def import_file_stream
    trips_command =
      "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"

    ActiveRecord::Base.connection.raw_connection.copy_data trips_command do
      File.open(@file_path) do |ff|
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

              from = @cities[trip['from']]
              to = @cities[trip['to']]
              bus = @buses[trip['bus']['number']]

              ActiveRecord::Base.connection.raw_connection.put_copy_data("#{from.id};#{to.id};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus.id}\n")

              str = +""
            end
          when nesting >= 1
            str << ch
          end
        end
      end
    end
  end

  def find_city(name)
    unless @cities.key?(name)
      @cities[name] = City.find_or_create_by(name: name)
    end

    @cities[name]
  end


  def find_service(name)
    unless @services.key?(name)
      @services[name] = Service.find_or_create_by(name: name)
    end

    @services[name]
  end

  def find_bus(bus)
    number = bus['number']
    unless @buses.key?(number)
      @buses[number] = Bus.find_or_initialize_by(number: number)
      @buses[number].model = bus['model']

      services = []
      bus['services'].each do |service|
        s = find_service(service)
        services << s
      end
      @buses[number].services = services
      @buses[number].save
    end

    @buses[number]
  end

  def clear_base
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end
end
