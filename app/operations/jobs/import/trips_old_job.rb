

  module Jobs
    module Import
        class TripsOldJob
            def initialize filename
              @filename = filename
            end
        
            def call
              json = JSON.parse(File.read(@filename))
              work(json)
            end
        
            private
            def work(json)
                ActiveRecord::Base.transaction do
                    City.delete_all
                    Bus.delete_all
                    Service.delete_all
                    Trip.delete_all
                    ActiveRecord::Base.connection.execute('delete from buses_services;')
                
                    json.each do |trip|
                      from = City.find_or_create_by(name: trip['from'])
                      to = City.find_or_create_by(name: trip['to'])
                      services = []
                      trip['bus']['services'].each do |service|
                        #s = Service.find_or_create_by(name: service)
                        services << service
                      end
                      bus = Bus.find_or_create_by(number: trip['bus']['number'])
                      bus.update(model: trip['bus']['model'], services: services)
                  
                      Trip.create!(
                        from: from,
                        to: to,
                        bus: bus,
                        start_time: trip['start_time'],
                        duration_minutes: trip['duration_minutes'],
                        price_cents: trip['price_cents'],
                      )
                    end
                end
            end
        end
    end
  end  
  
            