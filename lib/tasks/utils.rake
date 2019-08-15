# frozen_string_literal: true

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
desc 'Run import data on DB'
task :reload_json, [:file_name] => :environment do |_task, args|
  json = JSON.parse(File.read(args.file_name))

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Trip.delete_all

    # Import cities
    City.import(fetch_cities(json))
    Bus.import(fetch_buses(json))
    Trip.import(fetch_trips(json))
  end
end

def fetch_cities(json)
  json.inject(Set.new) { |s, v| s.add v['from'] }.map { |city| City.new(name: city) }
end

def fetch_buses(json)
  json.inject(Set.new) { |s, v| s.add v['bus'] }.map do |bus|
    Bus.new(number: bus['number'],
            model: bus['model'],
            services: bus['services'].map { |service| Bus::SERVICES.index(service) })
  end
end

def fetch_trips(json)
  json.map do |trip|
    Trip.new(
      from: City.find_by_name(trip['from']),
      to: City.find_by_name(trip['to']),
      start_time: trip['start_time'],
      duration_minutes: trip['duration_minutes'],
      price_cents: trip['price_cents'],
      bus: Bus.find_by_number(trip['bus']['number'])
    )
  end
end
