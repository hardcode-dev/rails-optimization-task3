module MyApp
  class Import
    attr_reader :file_name, :batch_size
    BusesService = Class.new(ActiveRecord::Base)

    class TripsJsonStreamHandler < ::Oj::ScHandler
      def initialize(&block)
        @root = true
        @block = block
      end

      def hash_start
        {}
      end

      def hash_set(h, k, v)
        h[k] = v
      end

      def array_start
        if @root
          @root = false
          return
        else
          []
        end
      end

      def array_append(a, v)
        if a
          a << v
        else
          @block.call(v)
        end
      end
    end

    def initialize(file_name, batch_size: 1000)
      @file_name = file_name
      @batch_size = batch_size
      @imported_buses = {}
      @imported_services = {}
      @imported_cities = {}
      @imported_trips = []
      @buses_services = []
    end

    def call
      ActiveRecord::Base.transaction do
        db_clear
        import
      end
    end

    private

    def import
      parse do |trip|
        from = find_or_create_city(trip['from'])
        to = find_or_create_city(trip['to'])
        service_names = trip['bus']['services']
        services = find_or_create_services(service_names)
        bus_number = trip['bus']['number']
        bus_model = trip['bus']['model']
        bus = find_or_create_bus(bus_number, bus_model, services)

        start_time = trip['start_time']
        duration = trip['duration_minutes']
        price = trip['price_cents']
        add_trip(bus, duration, from, price, start_time, to)
      end
      BusesService.import(@buses_services)
      Trip.import(@imported_trips)
    end

    def db_clear
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')
    end

    def parse(&block)
      io =
        if File.extname(file_name).downcase == '.gz'
          Zlib::GzipReader.open(file_name)
        else
          File.open(file_name, 'r')
        end
      Oj.sc_parse(TripsJsonStreamHandler.new(&block), io)
    ensure
      io.close
    end

    def find_or_create_city(city_name)
      @imported_cities[city_name] ||= City.create(name: city_name)
    end

    def find_or_create_services(service_names)
      service_names.map do |service|
        find_or_create_service(service)
      end
    end

    def find_or_create_service(service_name)
      @imported_services[service_name] ||= Service.create(name: service_name)
    end

    def find_or_create_bus(bus_number, model, services)
      bus = @imported_buses[bus_number]
      unless bus
        bus = Bus.create!(number: bus_number, model: model)
        services.each do |service|
          add_bus_service(bus, service)
        end
        @imported_buses[bus_number] = bus
      end
      bus
    end

    def add_bus_service(bus, service)
      @buses_services << { bus_id: bus.id, service_id: service.id }
      if @buses_services.size == batch_size
        BusesService.import(@buses_services)
        @buses_services = []
      end
    end

    def add_trip(bus, duration, from, price, start_time, to)
      @imported_trips <<
        Trip.new(
          from: from,
          to: to,
          bus: bus,
          start_time: start_time,
          duration_minutes: duration,
          price_cents: price,
        )

      if @imported_trips.size == batch_size
        Trip.import(@imported_trips)
        @imported_trips = []
      end
    end
  end
end
