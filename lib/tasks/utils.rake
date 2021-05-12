# Наивная загрузка данных из json-файла в БД
# ./bin/rake reload_json\["fixtures/small.json"\]

task :reload_json, [:file_name] => :environment do |_task, args|
  trips = []
  cities = {}
  buses = {}
  services = {}
  bus_services = []

  json = JSON.parse(File.read(args.file_name))
  # заюзать два варика с бачами и удалением и с копиврайтом
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute <<~SQL
      delete from cities;
      delete from buses;
      delete from services;
      delete from trips;
      delete from buses_services;
    SQL

    json.each do |trip|
      cities[trip['from']] ||= City.find_or_create_by(name: trip['from'])
      cities[trip['to']] ||= City.find_or_create_by(name: trip['to'])
      buses[trip['bus']['number']] ||= Bus.find_or_create_by(
        number: trip['bus']['number'],
        model: trip['bus']['model']
      )

      trip['bus']['services'].each do |service|
        services[service] ||= Service.find_or_create_by(name: service)

        bus_services << {
          bus_id: buses[trip['bus']['number']].id,
          service_id: services[service].id
        }
      end

      trips << {
        from_id: cities[trip['from']].id,
        to_id: cities[trip['to']].id,
        bus_id: buses[trip['bus']['number']].id,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      }
    end

    BusesServices.insert_all(bus_services.uniq)
    Trip.insert_all(trips)
  end
end
