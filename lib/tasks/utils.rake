# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  json = FastJsonparser.parse(File.read(args.file_name), symbolize_keys: false)

  ActiveRecord::Base.transaction do
    [
      City.table_name, Bus.table_name, Service.table_name,
      Trip.table_name, BusesService.table_name
    ].each do |table|
      ActiveRecord::Base.connection.truncate(table)
    end

    cities = {}
    trips = []
    services = {}
    busses = {}
    busses_services = {}
    trips = []

    json.each do |trip|
      cities[trip['from']] ||= City.create!(name: trip['from'])
      cities[trip['to']] ||= City.create!(name: trip['to'])
      from = cities[trip['from']]
      to = cities[trip['to']]
      busses[trip['bus']['number']] ||= Bus.create!(
        number: trip['bus']['number'],
        model: trip['bus']['model']
      )

      trip['bus']['services'].each do |service|
        services[service] ||= Service.create!(name: service)
        bs_key = "#{trip['bus']['number']}_#{trip['bus']['model']}"
        busses_services[bs_key] ||= BusesService.create!(
          bus: busses[trip['bus']['number']],
          service: services[service]
        )
      end

      trips << {
        from_id: from.id,
        to_id: to.id,
        bus_id: busses[trip['bus']['number']].id,
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents'],
      }
    end

    Trip.import!(trips)
  end
end
