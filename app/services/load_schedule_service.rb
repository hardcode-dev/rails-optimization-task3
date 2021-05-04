class LoadScheduleService
  attr_reader :file_name, :log
  def initialize(file_name, size = 0, log = true)
    @file_name = file_name
    @size = size
    @log = log
    @pb = ProgressBar.new(@size) if @size && @log

    @cities = {}
    @services = {}
    @buses = {}
    @buses_services = {}
    @trips = []
  end

  def clear_db
    puts("Deleting old data ") if @log
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    %i[buses buses_services cities services trips].each do |table|
      ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end

  def call(clear = true)
    json = JSON.parse(File.read(file_name))

    ActiveRecord::Base.transaction do
      clear_db if clear
      import_services

      puts("Массовый импорт данных из json-файла в БД") if @log
      json.each do |trip|
        from = city(trip['from'])
        to = city(trip['to'])
        bus = autobus(trip['bus']['number'], trip['bus']['model'])

        trip['bus']['services'].each do |service_name|
          bus_service(bus.number, @services[service_name])
        end

        @trips << Trip.new(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        )

        @pb.increment! if @size && @log
      end
      if @log
        benchmark = Benchmark.bm(20) do |bm|
          bm.report('Import Cities'){ City.import @cities.values }
          bm.report('Import Buses'){ Bus.import @buses.values }
          bm.report('Import Bus Services') do
            BusesService.import @buses_services.values 
          end
          bm.report('Import Trips'){ Trip.import @trips }
        end 
      else
        City.import @cities.values
        Bus.import @buses.values
        BusesService.import @buses_services.values 
        Trip.import @trips 
      end
    end
  end

  protected

  def import_services
    serv = Service.import([:name], Service::SERVICES.map{ |n| [n] })
    @services = Service::SERVICES.zip(serv.ids).to_h
  end

  def city(name)
    @cities[name] ||= City.new(name: name)
  end

  def autobus(number, model)
    @buses[number] ||= Bus.new(number: number, model: model)
  end

  def bus_service(bus_number, service_id)
    key = [bus_number, service_id]
    @buses_services[key] ||= BusesService.new(bus_id: bus_number, 
                                              service_id: service_id)
  end
end
