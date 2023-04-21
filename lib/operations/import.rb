module Operations
  class Import
    def initialize
      @services = {}
      @cities = {}
      @first_trips_line = true
      @first_buses_line = true
    end

    def truncate_tables!
      ActiveRecord::Base.connection.execute('truncate table cities, buses, services, trips, buses_services RESTART IDENTITY;')
    end

    def find_city_id(name)
      @cities[name] ||= ActiveRecord::Base.connection.execute("insert into cities (name) values ('#{name}') ON CONFLICT DO NOTHING RETURNING id").first['id']
    end

    def import_services!
      ActiveRecord::Base.connection.execute("insert into services (name) values ('#{Service::SERVICES.join('\'),(\'')}') RETURNING id, name").each do |result|
        @services[result['name']] = result['id']
      end
    end

    def insert_bus(model:, number:)
      ActiveRecord::Base.connection.execute("insert into buses (model, number) values ('#{model}', '#{number}') ON CONFLICT DO NOTHING RETURNING id").first['id']
    end

    def insert_bus_services(bus_id:, service_names:)
      service_names.map! { |n| "(#{bus_id}, #{find_service_id(n)})" }
      ActiveRecord::Base.connection.execute("insert into buses_services (bus_id, service_id) values #{service_names.join(',')} ON CONFLICT DO NOTHING")
    end

    def buses_services_sql_file
      # bus_id, service_id
      @buses_services_sql_file ||= File.open('log/buses_services_sql.txt', 'w+')
    end

    def trips_sql_file
      # start_time, duration_minutes, price_cents, from_id, to_id, bus_id
      @trips_sql_file ||= File.open('log/trips_sql.txt', 'w+')
    end

    def write_trip(bus_id, raw_data)
      if @first_trips_line
        trips_sql_file.write 'INSERT INTO trips (start_time, duration_minutes, price_cents, from_id, to_id, bus_id) VALUES '
        @first_trips_line = false
      else
        trips_sql_file.write ','
      end

      trips_sql_file.write <<SQL
('#{raw_data['start_time']}',
#{raw_data['duration_minutes']},
#{raw_data['price_cents']},
#{find_city_id(raw_data['from'])},
#{find_city_id(raw_data['to'])},
#{bus_id})
SQL
    end

    def write_bus_service(bus_id, service_name)
      if @services[service_name]
        if @first_buses_line
          buses_services_sql_file.write 'INSERT INTO buses_services (bus_id, service_id) VALUES '
          @first_buses_line = false
        else
          buses_services_sql_file.write ','
        end

        buses_services_sql_file.write "(#{bus_id},#{@services[service_name]})"
      end
    end

    def work(file)
      json = JSON.parse(File.read(file))
      truncate_tables!

      ActiveRecord::Base.transaction do
        # т.к. сервисов ограниченное небольшое количество их можно сразу добавить
        import_services!

        json.each do |raw_data|
          bus_id = insert_bus(model: raw_data['bus']['model'], number: raw_data['bus']['number'])

          raw_data['bus']['services'].each do |service_name|
            write_bus_service bus_id, service_name
          end

          write_trip bus_id, raw_data
        end

        buses_services_sql_file.rewind
        trips_sql_file.rewind
        ActiveRecord::Base.connection.execute(buses_services_sql_file.read)
        ActiveRecord::Base.connection.execute(trips_sql_file.read)
      end

      buses_services_sql_file.close
      trips_sql_file.close
    end
  end
end