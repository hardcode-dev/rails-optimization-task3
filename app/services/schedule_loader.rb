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

    @@services = {}
    Service.pluck(:name, :id).map{|sr| @@services[sr[0].to_sym] = sr[1]}

    # https://koshigoe.github.io/postgresql/ruby/2018/10/31/bulk-insert-vs-copy-in-postgres.html
    @base_connection = ActiveRecord::Base.connection
    @raw_conn = ActiveRecord::Base.connection.raw_connection
    @encoder = PG::TextEncoder::CopyRow.new

    @trips_command_raw = "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, model, number) from stdin"
    @buses_services_command_raw = "copy buses_services (service_id, model, number) from stdin"
    @bus_command_raw = "copy buses (model, number) from stdin"

    @nr2 = Array.new(2)
    @nr3 = Array.new(3)
    @nr7 = Array.new(7)

    ActiveRecord::Base.transaction do
      @raw_conn.exec('delete from buses_services;')
      @raw_conn.exec('delete from trips;')
      @raw_conn.exec('delete from cities;')
      @raw_conn.exec('delete from buses;')
      @base_connection.reset_pk_sequence!('cities')
      @base_connection.reset_pk_sequence!('buses')

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

    bus_number = trip['bus']['number']
    bus_model = trip['bus']['model']

    bus_key = "#{bus_number}-#{bus_model}"

    unless @buses.include?(bus_key)
      @raw_conn.copy_data @bus_command_raw, @encoder do
        @nr2 = bus_number, bus_model
        @raw_conn.put_copy_data(@nr2)
      end
      @buses << bus_key

      @raw_conn.copy_data @buses_services_command_raw, @encoder do
        trip["bus"]["services"].map do |srv|
          @nr3 = @@services[srv.to_sym], bus_number, bus_model
          @raw_conn.put_copy_data(@nr3)
        end
      end
    end

    @raw_conn.copy_data @trips_command_raw, @encoder do
      @nr7 = from_id,to_id, trip['start_time'],trip['duration_minutes'],trip['price_cents'],bus_number,bus_model
      @raw_conn.put_copy_data(@nr7)
    end
  end
end
