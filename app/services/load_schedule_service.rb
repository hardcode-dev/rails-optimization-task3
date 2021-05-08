class LoadScheduleService
  attr_reader :file_name, :log
  def initialize(file_name, size = 0, log = true)
    @file_name = file_name
    @size = size
    @log = log
    @pb = ProgressBar.new(@size) if @size && @log

    # # статически формируемые справочные данные
    # @services = {}

    # # динамически формируемые справочные данные
    # @cities = {}
    # @buses = {}
    # @buses_services = Set.new

    # # потоковые данные
    # trips = {}
  end

  def clear_db
    log("Deleting old data")

    %i(buses buses_services cities services trips).each { |t| reset_table(t) }
  end

  def call(clear = true)
    clear_db if clear
    init_references

    log("Поковый импорт данных из json-файла в БД")
    ActiveRecord::Base.transaction do
      trips_command =
        "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"

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
              if nesting == 0 # если закончился объект уровня trip, парсим и импортируем его
                trip = Oj.load(str)
                import(trip)
                @pb.increment! if @pb
                str = +""
              end
            when nesting >= 1
              str << ch
            end
          end
        end
      end
    end
    
    import_references
  end

  protected

  def init_references
    serv = Service.import([:name], Service::SERVICES.map{ |n| [n] })
    @services = Service::SERVICES.zip(serv.ids).to_h

    @cities = {}
    @buses = {}
    @buses_services = Set.new
  end

  def connection
    @connection ||= ActiveRecord::Base.connection.raw_connection
  end

  def import(trip)
    from_id = @cities[trip['from']]
    if !from_id
      from_id = @cities.length + 1
      @cities[trip['from']] = from_id
    end

    to_id = @cities[trip['to']]
    if !to_id
      to_id = @cities.length + 1
      @cities[trip['to']] = to_id
    end

    model = trip['bus']['model']
    number = trip['bus']['number']
    bus_key = [model, number]
    bus_id = @buses[bus_key]
    if !bus_id
      bus_id = @buses.length + 1
      @buses[bus_key] = bus_id
    end

    trip['bus']['services'].each do |service_name|
      @buses_services.add([bus_id, @services[service_name]])
    end

    # стримим подготовленный чанк данных в postgres
    connection.put_copy_data("#{from_id};#{to_id};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus_id}\n")
  end

  def import_references
    City.import [:name, :id], @cities.to_a
    Bus.import [:model, :number, :id], @buses.map{ |(k1, k2), v| [k1, k2, v] }
    BusesService.import [:bus_id, :service_id], @buses_services.to_a
  end

  private 

  def reset_table(table)
    ActiveRecord::Base.connection.execute("delete from #{table};")
    ActiveRecord::Base.connection.reset_pk_sequence!(table)
  end

  def log(msg)
    return unless @log

    puts msg
  end
end
