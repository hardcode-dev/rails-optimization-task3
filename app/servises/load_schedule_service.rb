class LoadScheduleService
  attr_reader :file_name
  def initialize(file_name)
    @file_name = file_name

    @cities = {}
    @services = {}
    @buses = {}
    @buses_services = {}
    @trips = []
  end

  def clear_db
    puts("Deleting old data ")
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    %i[buses buses_services cities services trips].each do |table|
      ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end

  def call(clear = true, size = 0)
    json = JSON.parse(File.read(file_name))
    pb = ProgressBar.new(size) if size

   ActiveRecord::Base.transaction do
      clear_db if clear

      puts("Массовый импорт данных из json-файла в БД")
      json.each do |trip|
        from = city(trip['from'])
        to = city(trip['to'])
        bus = autobus(trip['bus']['number'], trip['bus']['model'])

        trip['bus']['services'].each do |service_name|
          serv = service(service_name)
          bus_service(bus.number, serv.id)
        end

        @trips << Trip.new(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        )

        pb.increment! if size
      end
      benchmark = Benchmark.bm(20) do |bm|
        bm.report('Import Cities'){ City.import @cities.values }
        bm.report('Import Buses'){ Bus.import @buses.values }
        bm.report('Import Bus Services') do
          BusesService.import @buses_services.values 
        end
        bm.report('Import Trips'){ Trip.import @trips }
      end
    end
  end

  protected

  def city(name)
    @cities[name] ||= City.new(name: name)
  end

  def autobus(number, model)
    @buses[number] ||= Bus.new(number: number, model: model)
  end

  def service(name)
    @services[name] ||= Service.create!(name: name)
  end

  def bus_service(bus_number, service_id)
    key = [bus_number, service_id]
    @buses_services[key] ||= BusesService.new(bus_id: bus_number, 
                                              service_id: service_id)
  end
end
