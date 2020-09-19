# frozen_string_literal: true

class ReloadJsonStreamUtil
  attr_reader :file_name, :progress_bar
  def initialize(file_name, total = nil)
    @file_name = file_name
    # @total = total

    @cities = {}
    @services = {}
    @buses = {}
    @bus_services = {}
    @trips = []

    @progress_bar = ProgressBar.create(total: total, format: '%a, %J%%, %E [%c/%C] [%B]') if total
  end

  def clear_db
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    %i[buses buses_services cities services trips].each do |table|
      ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end

  def import_services
    res = Service.import([:name], Service::SERVICES.map { |n| [n] }, validate: false)
    @services = Service::SERVICES.zip(res.ids).to_h
  end

  def connection
    @connection ||= ActiveRecord::Base.connection.raw_connection
  end

  def run
    clear_db
    import_services
    @cities = {}
    @buses = {}
    @bus_services = Set.new

    ActiveRecord::Base.transaction do
      trips_command =
        "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"

      connection.copy_data trips_command do
        File.open(file_name) do |ff|
          nesting = 0
          str = +""

          until ff.eof?
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
                progress_bar.increment if progress_bar
                str = +""
              end
            when nesting >= 1
              str << ch
            end
          end
        end
      end
    end
    City.import [:name, :id], @cities.to_a
    Bus.import [:number, :model, :id], @buses.map { |(k1, k2), v| [k1, k2, v] }
    BusesService.import [:bus_id, :service_id], @bus_services.to_a
    a = 1
  end

  def import(trip)
    from_id = @cities[trip['from']]
    unless from_id
      from_id = @cities.size + 1
      @cities[trip['from']] = from_id
    end

    to_id = @cities[trip['to']]
    unless to_id
      to_id = @cities.size + 1
      @cities[trip['to']] = to_id
    end

    # bus_key = "#{trip['bus']['number']} | #{trip['bus']['model']}"
    number = trip['bus']['number']
    model = trip['bus']['model']
    raise ArgumentError, number unless number
    raise ArgumentError, model unless model
    bus_key = [number, model]
    bus_id = @buses[bus_key]
    unless bus_id
      bus_id = @buses.size + 1
      @buses[bus_key] = bus_id
    end

    services = trip['bus']['services']
    services&.each do |service_name|
      service_id = @services[service_name]
      raise ArgumentError, service_name unless service_id
      @bus_services.add([bus_id, service_id])
    end

    # стримим подготовленный чанк данных в postgres
    ActiveRecord::Base.connection.raw_connection.put_copy_data("#{from_id};#{to_id};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus_id}\n")
  end
end
