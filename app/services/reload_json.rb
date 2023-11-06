# frozen_string_literal: true

require 'oj'
class ReloadJson
  def initialize(file_name)
    @file_name = file_name
    @cities = {}
    @buses = {}
    @buses_services = []
  end

  def call
    ActiveRecord::Base.transaction do
      clear_tables
      create_services

      @connection = ActiveRecord::Base.connection.raw_connection
      trips_command =
        "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"

      @connection.copy_data trips_command do
        File.open(file_name) do |ff|
          nesting = 0
          str = String.new

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
                copy_trip(trip)

                str = String.new
              end
            elsif nesting >= 1
              str << ch
            end
          end
        end
      end

      Bus.import buses.values
      City.import cities.values
      BusesService.import buses_services
    end
  end

  private

  attr_reader :cities, :buses, :buses_services, :services, :file_name

  def create_services
    services = []
    Service::SERVICES.each do |name|
      services << Service.new(name: name)
    end
    Service.import services
    @services = Service.all.to_h { |service| [service.name, service.id] }
  end

  def clear_tables
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusesService.delete_all
  end

  def copy_trip(trip)
    from_id = cities.dig(trip['from'], 'id')
    to_id = cities.dig(trip['to'], 'id')
    service_ids = services.values_at(*trip['bus']['services'])
    bus_key = "#{trip['bus']['model']} #{trip['bus']['number']}"
    bus_id = buses.dig(bus_key, 'id')

    unless from_id
      id = cities.size + 1
      cities[trip['from']] = { 'id' => id, 'name' => trip['from'] }
      from_id = id
    end

    unless to_id
      if cities[trip['from']] == @cities[trip['to']]
        to_id = from_id
      else
        id = cities.size + 1
        @cities[trip['to']] = { 'id' => id, 'name' => trip['to'] }
        to_id = id
      end
    end

    unless bus_id
      id = buses.size + 1
      buses[bus_key] =
        { 'id' => id, 'number' => trip['bus']['number'], 'model' => trip['bus']['model'] }
      service_ids.each { |service_id| buses_services << { 'service_id' => service_id, 'bus_id' => id } }
      bus_id = id
    end

    @connection.put_copy_data("#{from_id};#{to_id};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus_id}\n")
  end
end
