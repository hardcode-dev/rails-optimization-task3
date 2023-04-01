module MyApp
  class Import
    attr_reader :file_name

    def initialize(file_name)
      @file_name = file_name
    end

    def call
      json = JSON.parse(File.read(file_name))

      ActiveRecord::Base.transaction do
        City.delete_all
        Bus.delete_all
        Service.delete_all
        Trip.delete_all
        ActiveRecord::Base.connection.execute('delete from buses_services;')

        json.each do |trip|
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
      end
    end

    private

    def find_or_create_city(city_name)
      City.find_or_create_by(name: city_name)
    end

    def find_or_create_services(service_names)
      service_names.map do |service|
        find_or_create_service(service)
      end
    end

    def find_or_create_service(service)
      Service.find_or_create_by(name: service)
    end

    def find_or_create_bus(bus_number, model, services)
      bus = Bus.find_or_create_by(number: bus_number)
      bus.update(model: model, services: services)
      bus
    end

    def add_trip(bus, duration, from, price, start_time, to)
      Trip.create!(
        from: from,
        to: to,
        bus: bus,
        start_time: start_time,
        duration_minutes: duration,
        price_cents: price,
      )
    end
  end
end
