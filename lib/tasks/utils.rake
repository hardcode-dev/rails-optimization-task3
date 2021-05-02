# frozen_string_literal: true

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
require 'benchmark'
task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.measure do
    json = Oj.load(File.read(args.file_name))
    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')
      bus_services_ids = Set.new
      buses = {}
      services = {}
      trips = []
      cities = {}
      json.each do |trip|
        from = cities[trip['from']] ||= City.create!(name: trip['from'])
        to = cities[trip['to']] ||= City.create!(name: trip['to'])
        bus = buses[trip['bus']['number']] ||= Bus.create!(number: trip['bus']['number'], model: trip['bus']['model'])
        trip['bus']['services'].each do |service|
          service = services[service] ||= Service.create!(name: service)
          bus_services_ids << [bus.id, service.id]
        end

        trips << Trip.new(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents']
        )
      end
      BusesService.import %i[bus_id service_id], bus_services_ids.to_a
      Trip.import trips
    end
  end
  puts time
end
