module Jobs
  module Import
    class TripsJob
      def initialize filename, **args
        @filename = filename
        @progressbar_enable = args[:progressbar]
      end

      def call
        json = JSON.parse(File.read(@filename))
        
        @progressbar = ProgressBar.create(
          total: json.size,
          format: '%a, %J, %E, %B'
        ) if @progressbar_enable  
        cleanup_db!
        fill_models!(json)
      end

      private
      def fill_models!(json)
        ActiveRecord::Base.transaction do
            cities = {}
            trips = []
            buses = {}
            json.each do |trip|
        
              from = cities[trip['from']]
              from = cities[trip['from']] = City.find_or_create_by(name: trip['from']) unless from
                 
              to = cities[trip['to']]
              to = cities[trip['to']] = City.find_or_create_by(name: trip['to']) unless to
              
              services = []
              trip['bus']['services'].each do |service|
                services << service
              end
              bus = buses[trip['bus']['number']]
              unless bus
                bus = Bus.find_by_number(trip['bus']['number'])
                bus ||= Bus.create(
                  number: trip['bus']['number'],
                  model: trip['bus']['model'], 
                  services: services
                )
                buses[trip['bus']['number']] = bus
              end
        
              trips << Trip.new(
                  from: from,
                  to: to,
                  bus: bus,
                  start_time: trip['start_time'],
                  duration_minutes: trip['duration_minutes'],
                  price_cents: trip['price_cents'],
                )
              if trips.size == 10000
                Trip.import trips
                trips = []
              end
              @progressbar.increment if @progressbar_enable
            end
            Trip.import trips
          end
      end

      def cleanup_db!
        ActiveRecord::Base.transaction do
            City.delete_all
            Bus.delete_all
            Service.delete_all
            Trip.delete_all
            ActiveRecord::Base.connection.execute('delete from buses_services;')
        end
      end

    end
  end
end  

        