# frozen_string_literal: true

module JsonImporter

  class << self
    def perform(file_name)
      ActiveRecord::Base.transaction do
        clear_data
        import(file_name)
      end
    end

    private

    def import(file_name)
      @cities = {}
      @all_services = {}
      @buses = {}

      trips = Oj.load(File.read(file_name)).map! do |trip|
        @cities[trip['from']] ||= City.find_or_create_by(name: trip['from']).id
        @cities[trip['to']] ||= City.find_or_create_by(name: trip['to']).id
        @buses[trip['bus']['number']] ||= build_bus(trip)

        trip_args(trip)
      end

      Trip.import! trips
    end

    def trip_args(trip)
      {
        from_id: @cities[trip['from']],
        to_id: @cities[trip['to']],
        bus_id: @buses[trip['bus']['number']],
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
    end

    def build_bus(trip)
      services = []
      trip['bus']['services'].each do |service|
        @all_services[service] ||= Service.create(name: service)
        services << @all_services[service]
      end
      Bus.create(number: trip['bus']['number'], model: trip['bus']['model'], services: services).id
    end

    def clear_data
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      BusesService.delete_all
    end
  end

end
