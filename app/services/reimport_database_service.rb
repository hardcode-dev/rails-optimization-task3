# frozen_string_literal: true

class ReimportDatabaseService
  def initialize(args = {})
    @file_name = args[:file_name]
  end

  def call
    reload_json
  end

  private

  attr_reader :file_name

  def reload_json
    json = Oj.load(File.read(file_name))

    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("delete from cities;
                                             delete from buses;
                                             delete from services;
                                             delete from trips;
                                             delete from buses_services;")
      all_services = []
      Service::SERVICES.each do |service|
        s = Service.new(name: service)
        all_services << s
      end
      Service.import(all_services)
      service_cache = {}
      Service.select(:name, :id).map do |s|
        service_cache[s.attributes['name']] = s.attributes['id']
      end
      trips = []
      cities = {}
      buses = []
      buses_services = []
      buses_cache = {}
      json.each do |trip|
        from = cities[trip['from']] || City.create(name: trip['from'])
        cities[trip['from']] = from.id if cities[trip['from']].blank?
        to = cities[trip['to']] || City.create(name: trip['to'])
        cities[trip['to']] = to.id if cities[trip['to']].blank?

        services = []
        bus_id = if buses_cache["#{trip['bus']['model']} #{trip['bus']['number']}"]
                   buses_cache["#{trip['bus']['model']} #{trip['bus']['number']}"]
                 else
                   b = Bus.create(model: trip['bus']['model'], number: trip['bus']['number'])
                   buses_cache["#{trip['bus']['model']} #{trip['bus']['number']}"] = b.id
                   b.id
                 end

        trip['bus']['services'].each do |serv|
          buses_services << { bus_id: bus_id, service_id: service_cache[serv].to_i }
        end

        trips << Trip.new(
          from_id: cities[trip['from']],
          to_id: cities[trip['from']],
          bus_id: bus_id,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents']
        )
      end
      BusService.import(buses_services)
      Trip.import(trips)
    end
  end
end
