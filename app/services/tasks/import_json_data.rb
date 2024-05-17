# frozen_string_literal: true

module Tasks
  class ImportJsonData
    BATCH_SIZE = 1000

    attr_accessor :cities, :trips, :services, :buses_hash, :buses_array, :buses_services, :cities_hash
    attr_reader :filepath

    class << self
      def call(filepath:)
        new(filepath).call
      end
    end

    def initialize(filepath)
      @filepath = filepath
      @cities = []
      @cities_hash = {}
      @trips = []
      @services = {}
      @buses_hash = {}
      @buses_array = []
      @buses_services = []
    end

    def call
      ActiveRecord::Base.transaction do
        create_services

        File.open(filepath) do |ff|
          nesting = 0
          str = +''

          until ff.eof?
            ch = ff.read(1) # читаем по одному символу
            if ch == '{' # начинается объект, повышается вложенность
              nesting += 1
              str << ch
            elsif ch == '}' # заканчивается объект, понижается вложенность
              nesting -= 1
              str << ch
              if nesting.zero? # если закончился объкет уровня trip, парсим и импортируем его
                trip = Oj.load(str)
                process_trip(trip)
                str = +''
              end
            elsif nesting >= 1
              str << ch
            end
          end
        end
      end
    end

    private

    def create_services
      Service::SERVICES.each do |service|
        services[service] = Service.create!(name: service).id
      end
    end

    def process_trip(trip)
      bus_key = "#{trip['bus']['number']}-#{trip['bus']['model']}"

      trip['bus']['services'].each do |service|
        buses_services << [bus_key, services[service]]
      end

      buses_array << [trip['bus']['number'], trip['bus']['model']]

      cities << [trip['from']]
      cities << [trip['to']]

      trips << [trip['from'], trip['to'], trip['start_time'], trip['duration_minutes'], trip['price_cents'], bus_key]

      if trips.size == BATCH_SIZE
        City.import %i[name], cities.uniq!, on_duplicate_key_ignore: true
        update_cities_hash(cities)

        Bus.import %i[number model], buses_array, on_duplicate_key_ignore: true
        update_bus_hash(buses_array)

        trips.map! do |trip|
          [cities_hash[trip[0]], cities_hash[trip[1]], trip[2], trip[3], trip[4], buses_hash[trip[5]]]
        end
        Trip.import %i[from_id to_id start_time duration_minutes price_cents bus_id], trips

        buses_services.map! { |buses_service| [buses_hash[buses_service.first], buses_service.last] }
        BusesService.import %i[bus_id service_id], buses_services, on_duplicate_key_ignore: true

        @buses_array = []
        @trips = []
        @cities = []
        @buses_services = []
      end
    end

    def update_bus_hash(buses_array)
      buses_array.uniq.each do |bus|
        key = "#{bus.first}-#{bus.last}"
        buses_hash[*key] = Bus.find_by(number: bus.first, model: bus.last).id unless buses_hash[*key]
      end
    end

    def update_cities_hash(cities)
      cities.each do |city|
        cities_hash[*city] = City.find_by(name: city).id unless cities_hash[*city]
      end
    end
  end
end
