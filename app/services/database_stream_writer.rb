class DatabaseStreamWriter

  def initialize(file_name)
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusesService.delete_all
    Service.import(Service.services.map{|s| Service.new(name: s)})
    @servises = Service.all.to_a

    @file_name = file_name
    @cities = {}
    @last_city_id = 0
    @buses = {}
    @last_bus_id  = 0

    @temp_file = File.open('fixtures/buses_services_temp.txt','w')

  end

  def write
    ActiveRecord::Base.transaction do
      trips_command =
      "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"
    
      @connection = Trip.connection.raw_connection
      @connection.copy_data trips_command do
        File.open(@file_name) do |ff|
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
                str = +""
              end
            when nesting >= 1
              str << ch
            end
          end
        end
      end

      City.import @cities.values
      @cities = []
      Bus.import @buses.values, batch_size: 1000
      @buses = []
      @temp_file.close

      buses_command =
      "copy buses_services (bus_id, service_id) from stdin with csv delimiter ';'"
    
      @connection.copy_data buses_command do
        File.open('fixtures/buses_services_temp.txt') do |ff|
          while !ff.eof?
            @connection.put_copy_data(ff.readline)
          end
        end
      end

    end

  end

  def import(trip)
    from = @cities[trip['from']]
    if from.nil?
      from = {id: @last_city_id += 1, name: trip['from']}
      @cities[trip['from']] = from
    end
    to = @cities[trip['to']]
    if to.nil?
      to = {id: @last_city_id += 1, name: trip['to']}
      @cities[trip['to']] = to
    end
    bus = @buses["#{trip['bus']['model']}-#{trip['bus']['number']}"]
    if bus.nil?
      bus = {id: @last_bus_id += 1, number: trip['bus']['number'], model: trip['bus']['model']}
      @servises.select{|s| trip['bus']['services'].include?(s.name)}.each do |service|
        @temp_file.write("#{@last_bus_id};#{service.id}\n")
      end
      @buses["#{trip['bus']['model']}-#{trip['bus']['number']}"] = bus
    end
  
    # стримим подготовленный чанк данных в postgres
    @connection.put_copy_data("#{from[:id]};#{to[:id]};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus[:id]}\n")
  end


end