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
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute("delete from buses_services;")

      json.each do |trip|
        from = City.find_or_create_by(name: trip["from"])
        to = City.find_or_create_by(name: trip["to"])
        services = []
        trip["bus"]["services"].each do |service|
          s = Service.find_or_create_by(name: service)
          services << s
        end
        bus = Bus.find_or_create_by(number: trip["bus"]["number"])
        bus.update(model: trip["bus"]["model"], services: services)

        Trip.create!(
          from: from,
          to: to,
          bus: bus,
          start_time: trip["start_time"],
          duration_minutes: trip["duration_minutes"],
          price_cents: trip["price_cents"]
        )
      end
      # ActiveRecord::Base.transaction do
      #   ActiveRecord::Base.connection.execute("delete from cities;
      #                                          delete from buses;
      #                                          delete from services;
      #                                          delete from trips;
      #                                          delete from buses_services;")
      #   all_services = []
      #   Service::SERVICES.each do |service|
      #     s = Service.new(name: service)
      #     all_services << s
      #   end
      #
      #   Service.import(all_services)
      #   service_cache = {}
      #   Service.select(:name, :id).map do |s|
      #     service_cache[s.attributes['name']] = s.attributes['id']
      #   end
      #   trips = []
      #   cities = {}
      #   buses_services = []
      #   buses_cache = {}
      #
      #   json.each do |trip|
      #     from = cities[trip['from']] || City.create(name: trip['from'])
      #     cities[trip['from']] = from.id if cities[trip['from']].blank?
      #     to = cities[trip['to']] || City.create(name: trip['to'])
      #     cities[trip['to']] = to.id if cities[trip['to']].blank?
      #
      #     bus_id = if buses_cache["#{trip['bus']['model']} #{trip['bus']['number']}"]
      #                buses_cache["#{trip['bus']['model']} #{trip['bus']['number']}"]
      #              else
      #                b = Bus.create(model: trip['bus']['model'], number: trip['bus']['number'])
      #                buses_cache["#{trip['bus']['model']} #{trip['bus']['number']}"] = b.id
      #                b.id
      #              end
      #
      #     trip['bus']['services'].each do |serv|
      #       buses_services << BusService.new(bus_id: bus_id, service_id: service_cache[serv] )
      #     end
      #
      #     trips << Trip.new(
      #       from_id: cities[trip['from']],
      #       to_id: cities[trip['from']],
      #       bus_id: bus_id,
      #       start_time: trip['start_time'],
      #       duration_minutes: trip['duration_minutes'],
      #       price_cents: trip['price_cents']
      #     )
      #   end
      #   BusService.import(buses_services)
      #   Trip.import(trips)
      # end
    end
  end
end
