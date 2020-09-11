class ReloadJsonServiceStream
  attr_reader :file_name

  def initialize(args)
    @file_name = args[:file_name]
    @trips_count = args[:count].to_i if args[:count]
    @cities = {}
    @services = {}
    @buses = {}
    @cities = {}
    @bs = []
    @con = nil
  end

  def run
    if @trips_count
      @progressbar = ProgressBar.create(format: "%a %e %P% Processed: %c from %C")
      @progressbar.total = @trips_count
    end

    ActiveRecord::Base.transaction do
      truncate_tables
      @con = ActiveRecord::Base.connection.raw_connection
      copy_trips
      copy_cities
      copy_services
      copy_buses
      copy_bs
    end
  end

  def truncate_tables
    %w[cities buses services trips buses_services].each { |table_name| truncate_table(table_name) }
  end

  def truncate_table(table_name)
    ActiveRecord::Base.connection.execute("TRUNCATE #{table_name} RESTART IDENTITY")
  end

  def copy_trips
    command =
        "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"

    @con.copy_data command do
      File.open(file_name) do |ff|
        nesting = 0
        str = +""
        trips_parsed = 0

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
                import_trip(trip)
                if @progressbar.present?
                  trips_parsed += 1
                  @progressbar.progress = trips_parsed
                end
                str = ""
              end
            when nesting >= 1
              str << ch
          end
        end
      end
    end
  end

  def copy_cities
    command =
        "copy cities (name) from stdin with csv delimiter ';'"

    @con.copy_data command do
      @cities.keys.each do |name|
        @con.put_copy_data("#{name}\n")
      end
    end
  end

  def copy_services
    command =
      "copy services (name) from stdin with csv delimiter ';'"

    @con.copy_data command do
      @services.keys.each do |name|
        @con.put_copy_data("#{name}\n")
      end
    end
  end

  def copy_buses
    command =
        "copy buses (number, model) from stdin with csv delimiter ';'"

    @con.copy_data command do
      @buses.values.each do |bus|
        @con.put_copy_data("#{bus['number']};#{bus['model']}\n")
      end
    end
  end

  def copy_bs
    command =
        "copy buses_services (bus_id, service_id) from stdin with csv delimiter ';'"

    @con.copy_data command do
      @bs.each do |bs|
        @con.put_copy_data("#{bs[0]};#{bs[1]}\n")
      end
    end
  end

  def import_trip(trip)
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

    bus_id = import_bus_with_service(trip)

    @con.put_copy_data("#{from_id};#{to_id};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus_id}\n")
  end

  def import_bus_with_service(trip)
    if @buses[bus_key(trip['bus'])].nil?
      id = @buses.size + 1
      @buses[bus_key(trip['bus'])] = {
          'model' => trip['bus']['model'],
          'number' => trip['bus']['number'],
          'id' => id
      }
      trip['bus']['services'].each do |service|
        service_id = @services[service]

        if !service_id
          service_id = @services.size + 1
          @services[service] = service_id
        end

        @bs << [id, service_id]
      end
      id
    else
      @buses[bus_key(trip['bus'])]['id']
    end
  end

  def bus_key(bus)
    "#{bus['number']}-#{bus['model']}"
  end
end