require 'active_record'
require 'activerecord-import'

# frozen_string_literal: true
STrip = Struct.new(:from, :to, :start_time, :duration_minutes, :price_cents, :number, :model)
SBus = Struct.new(:number, :model, :services)

class ScheduleLoader
  def self.call(file_name)
    @cities = {}
    @services = {}
    @buses = Set.new

    @trips_command = "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, model, number) from stdin with csv delimiter ';'"
    @trips_command_raw = "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, model, number) from stdin"

    @bus_command = "copy buses (model, number) from stdin with csv delimiter ';'"
    @buses_services_command = "copy buses_services (service_id, model, number) from stdin with csv delimiter ';'"
    @buses_services_command_raw = "copy buses_services (service_id, model, number) from stdin"


    @@services = {}
    Service.pluck(:name, :id).map{|sr| @@services[sr[0].to_sym] = sr[1]}

    ActiveRecord::Base.transaction do

      time_start = Time.now

      ActiveRecord::Base.connection.execute('delete from buses_services;')

      ActiveRecord::Base.connection.execute('delete from buses_services;')
      ActiveRecord::Base.connection.execute('delete from trips;')
      ActiveRecord::Base.connection.execute('delete from cities;')
      ActiveRecord::Base.connection.execute('delete from buses;')

      # Trip.delete_all
      # City.delete_all
      # Bus.delete_all
      ActiveRecord::Base.connection.reset_pk_sequence!('cities')
      ActiveRecord::Base.connection.reset_pk_sequence!('buses')

      File.open(file_name) do |ff|
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
            if nesting == 0 # если закончился объкет уровня trip, парсим и импортируем его

              trip = Oj.load(str)

              import_trip(trip)

              str = +''
            end
          elsif nesting >= 1
            str << ch
          end
        end
      end
      City.import @cities.map {|cc| ({id: cc[1], name: cc[0]})}
      end_time = Time.now
      pp (end_time - time_start)
    end
  end

  def self.import_trip(trip)
    from_id = @cities[trip['from']]
    unless from_id
      from_id = @cities.size + 1
      @cities[trip['from']] = from_id
    end

    to_id = @cities[trip['to']]
    unless to_id
      to_id = @cities.size + 1
      @cities[trip['to']] = to_id
    end

    bus_key = "#{trip['bus']['number']}-#{trip['bus']['model']}"

    bus_number = trip['bus']['number']
    bus_model = trip['bus']['model']

    unless @buses.include?(bus_key)
      ActiveRecord::Base.connection.raw_connection.copy_data @bus_command do
        ActiveRecord::Base.connection.raw_connection.put_copy_data("#{bus_number};#{bus_model}\n")
      end
      @buses << bus_key
      ActiveRecord::Base.connection.raw_connection.copy_data @buses_services_command do
        trip["bus"]["services"].map do |srv|
          ActiveRecord::Base.connection.raw_connection.put_copy_data("#{@@services[srv.to_sym]};#{bus_number};#{bus_model}\n")
        end
      end
    end

    ActiveRecord::Base.connection.raw_connection.copy_data @trips_command do
      ActiveRecord::Base.connection.raw_connection.put_copy_data("#{from_id};#{to_id};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{bus_number};#{bus_model}\n")
    end
  end
end
