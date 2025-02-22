# frozen_string_literal: true

class DataLoader
  TRIPS_COMMAND =
    "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"
  CITIES_COMMAND = "copy cities (id, name) from stdin with csv delimiter ';'"
  BUSES_COMMAND = "copy buses (id, number, model) from stdin with csv delimiter ';'"
  SERVICES_COMMAND = "copy services (id, name) from stdin with csv delimiter ';'"
  BUSES_SERVICES_COMMAND = "copy buses_services (bus_id, service_id) from stdin with csv delimiter ';'"

  def self.load(filename)
    new(filename).load
  end

  def initialize(filename)
    @stream = JsonStreamer.stream(filename)
    @cities = {}
    @services = {}
    @buses = {}
    @buses_services = []
  end

  def load
    ActiveRecord::Base.transaction do
      clean_database
      connection = ActiveRecord::Base.connection.raw_connection

      ActiveRecord::Base.connection.raw_connection.copy_data TRIPS_COMMAND do
        stream.each do |trip|
          from = city(trip['from'])
          to = city(trip['to'])

          if buses[trip['bus']['number']].nil?
            bus_services = []
            trip['bus']['services'].each do |name|
              bus_services << service(name)
            end

            create_bus(trip['bus']['number'], trip['bus']['model'])
            create_bus_services(buses[trip['bus']['number']], bus_services)
          end

          bus = buses[trip['bus']['number']]

          connection.put_copy_data("#{from[:id]};#{to[:id]};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus[:id]}\n")
        end
      end

      ActiveRecord::Base.connection.raw_connection.copy_data CITIES_COMMAND do
        cities.each do |name, attrs|
          connection.put_copy_data("#{attrs[:id]};#{name}\n")
        end
      end

      ActiveRecord::Base.connection.raw_connection.copy_data BUSES_COMMAND do
        buses.each do |number, attrs|
          connection.put_copy_data("#{attrs[:id]};#{number};#{attrs[:model]}\n")
        end
      end

      ActiveRecord::Base.connection.raw_connection.copy_data SERVICES_COMMAND do
        services.each do |name, attrs|
          connection.put_copy_data("#{attrs[:id]};#{name}\n")
        end
      end

      ActiveRecord::Base.connection.raw_connection.copy_data BUSES_SERVICES_COMMAND do
        buses_services.each do |bus_id, service_id|
          connection.put_copy_data("#{bus_id};#{service_id}\n")
        end
      end
    end
  end

  private

  attr_reader :stream
  attr_accessor :cities, :services, :buses, :buses_services

  def clean_database
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end

  def city(name)
    cities[name] ||= { id: cities.size + 1 }
  end

  def service(name)
    services[name] ||= { id: services.size + 1 }
  end

  def create_bus(number, model)
    buses[number] = { id: buses.size + 1, model: }
  end

  def create_bus_services(bus, services)
    services.map do |service|
      @buses_services << [bus[:id], service[:id]]
    end
  end
end
