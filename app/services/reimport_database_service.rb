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
      trips = []
      cities = {}
      buses = []

      json.each do |trip|
        from = cities[trip["from"]] || City.create(name: trip["from"])
        cities[trip["from"]] = from.id if cities[trip["from"]].blank?
        to = cities[trip["to"]] || City.create(name: trip["to"])
        cities[trip["to"]] = to.id if cities[trip["to"]].blank?

        services = []
        bus = Bus.find_or_create_by(model: trip["bus"]["model"], number: trip["bus"]["number"])
        bus.services << Service.where(name: trip["bus"]["services"])

        trips << Trip.new(
          from_id: cities[trip["from"]],
          to_id: cities[trip["from"]],
          bus: bus,
          start_time: trip["start_time"],
          duration_minutes: trip["duration_minutes"],
          price_cents: trip["price_cents"]
        )
      end
      Trip.import(trips)
    end
  end
end
