# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
# rake 'reload_json[fixtures/small.json]'

task :reload_json, [:file_name] => :environment do |_task, args|
  json = JSON.parse(File.read(args.file_name))

  ActiveRecord::Base.transaction do
    Bus.delete_all
    Trip.delete_all

    import_buses(json).
      then { |buses| buses.results.to_h }.
      then { |buses| import_trips(json, buses)}
  end
end

def import_buses(json)
  buses = []
  json.each do |obj|
    bus_obj = obj['bus']
    bus = Bus.new(
      number: bus_obj['number'],
      model: bus_obj['model'],
      services: bus_obj['services']
    )
    buses << bus
  end
  Bus.import(buses, on_duplicate_key_update: {}, returning: [:number, :id])
end

def import_trips(json, buses)
  trips = []
  json.each do |trip_obj|
    bus_id = buses[trip_obj['bus']['number']]

    trip = Trip.new(
      from: trip_obj['from'],
      to: trip_obj['to'],
      bus_id: bus_id,
      start_time: trip_obj['start_time'],
      duration_minutes: trip_obj['duration_minutes'],
      price_cents: trip_obj['price_cents'],
    )
    trips << trip
  end
  Trip.import(trips, validate: false)
end
