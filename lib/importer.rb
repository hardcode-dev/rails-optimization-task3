# frozen_string_literal: true

class Importer
  TRUNCATE_SQL = <<~SQL.squish
    TRUNCATE trips, services, cities, buses_services, buses  CASCADE;
  SQL

  TRIPS_COMMAND = "copy trips (from_id, to_id, start_time, duration_minutes, price_cents, bus_id) from stdin with csv delimiter ';'"
  CITIES_COMMAND = "copy cities (id, name) from stdin with csv delimiter ';'"
  BUSES_COMMAND = "copy buses (id, number, model) from stdin with csv delimiter ';'"
  BUSES_SERVICES_COMMAND = "copy buses_services (bus_id, service_id) from stdin with csv delimiter ';'"

  @@city_by_name = {}
  @@buses_by_number = {}
  @@services = {}

  def self.call(stream)
    ActiveRecord::Base.connection.execute(TRUNCATE_SQL)
    ActiveRecord::Base.transaction do
      Service::SERVICES.each_with_index do |s, i|
        @@services[s] ||= {}
        @@services[s] = { id: i, name: s }
      end

      Service.import @@services.values

      ActiveRecord::Base.connection.raw_connection.copy_data TRIPS_COMMAND do
        raw = ActiveRecord::Base.connection.raw_connection
        current_key = ''
        nested_key = ''

        current_obj = {}
        nested_obj_lvl = 0
        nested_arr_lvl = 0

        parser = JSON::Stream::Parser.new
        parser.start_object do
          nested_obj_lvl += 1
        end
        parser.end_object do
          nested_obj_lvl -= 1
          if nested_obj_lvl.zero?
            transaction(current_obj, raw)
            current_obj = {}
          end
        end
        parser.start_array    { nested_arr_lvl += 1 }
        parser.end_array      { nested_arr_lvl -= 1 }

        parser.key do |k|
          if nested_obj_lvl.eql? 1
            current_key = k
          elsif nested_obj_lvl.eql? 2
            nested_key = k
          end
        end

        parser.value do |v|
          if nested_arr_lvl.eql?(2) && nested_obj_lvl.eql?(2)
            current_obj[current_key][nested_key] ||= []
            current_obj[current_key][nested_key] << v
          elsif nested_obj_lvl.eql? 2
            current_obj[current_key] ||= {}
            current_obj[current_key][nested_key] = v
          elsif nested_obj_lvl.eql? 1
            current_obj[current_key] = v
          end
        end

        stream.each_char do |c|
          parser << c
        end
      end

      ActiveRecord::Base.connection.raw_connection.copy_data CITIES_COMMAND do
        raw = ActiveRecord::Base.connection.raw_connection
        @@city_by_name.each_value do |v|
          raw.put_copy_data("#{v[:id]};#{v[:name]}\n")
        end
      end

      ActiveRecord::Base.connection.raw_connection.copy_data BUSES_COMMAND do
        raw_bus = ActiveRecord::Base.connection.raw_connection
        @@buses_by_number.each_value do |v|
          raw_bus.put_copy_data("#{v[:id]};#{v[:number]};#{v[:model]}\n")
        end
      end

      ActiveRecord::Base.connection.raw_connection.copy_data BUSES_SERVICES_COMMAND do
        raw_services = ActiveRecord::Base.connection.raw_connection
        @@buses_by_number.each_value do |v|
          next unless v[:services]

          v[:services].each do |service|
            raw_services.put_copy_data("#{v[:id]};#{@@services[service][:id]}\n")
          end
        end
      end
    end
  end

  def self.transaction(trip, connection)
    from_obj = @@city_by_name[trip['from']]

    unless from_obj
      from_obj = { name: trip['from'], id: @@city_by_name.keys.size + 1 }
      @@city_by_name[trip['from']] = from_obj
    end

    to_obj = @@city_by_name[trip['to']]

    unless to_obj
      to_obj = { name: trip['to'], id: @@city_by_name.keys.size + 1 }
      @@city_by_name[trip['to']] = to_obj
    end

    bus_number = trip['bus']['number']

    buses_obj = @@buses_by_number[bus_number]

    unless buses_obj
      buses_obj = { id: @@buses_by_number.keys.size + 1, number: bus_number, model: trip['bus']['model'],
                    services: trip['bus']['services'] }
      @@buses_by_number[bus_number] = buses_obj
    end

    data = "#{from_obj[:id]};#{to_obj[:id]};#{trip['start_time']};#{trip['duration_minutes']};#{trip['price_cents']};#{buses_obj[:id]}\n"
    connection.put_copy_data(data)
  end
end
