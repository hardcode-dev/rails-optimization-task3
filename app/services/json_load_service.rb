# frozen_string_literal: true

class JsonLoadService

  def self.call(file_name)
    json = JSON.parse(File.read("fixtures/#{file_name}"))

    # dictionary - forward!

    services = Set.new
    cities = Set.new
    buses = Set.new

    json.each do |trip|
      trip['bus']['services'].each { |name| services << { name: name } }
      cities << { name: trip['to'] }
      cities << { name: trip['from'] }
      buses  << { number: trip['bus']['number'], model: trip['bus']['model'] }
    end

    Service.import services.to_a, validate: false
    City.import cities.to_a
    Bus.import buses.to_a


    ActiveRecord::Base.transaction do
      json.each do |trip|
        from = City.find_or_create_by(name: trip['from'])
        to = City.find_or_create_by(name: trip['to'])
        # services = []
        trip['bus']['services'].each do |service|
          s = Service.find_or_create_by(name: service)
          #services << s
        end
        bus = Bus.find_or_create_by(number: trip['bus']['number'])
        # bus.update(model: trip['bus']['model'], services: services)

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


# ActiveRecord::Base.transaction do
    #   json.each do |trip|
    #     from = City.find_or_create_by(name: trip['from'])
    #     to = City.find_or_create_by(name: trip['to'])
    #     services = []
    #     trip['bus']['services'].each do |service|
    #       s = Service.find_or_create_by(name: service)
    #       services << s
    #     end
    #     bus = Bus.find_or_create_by(number: trip['bus']['number'])
    #     bus.update(model: trip['bus']['model'], services: services)

    #     Trip.create!(
    #       from: from,
    #       to: to,
    #       bus: bus,
    #       start_time: trip['start_time'],
    #       duration_minutes: trip['duration_minutes'],
    #       price_cents: trip['price_cents'],
    #     )
    #   end