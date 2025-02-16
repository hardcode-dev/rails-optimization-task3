# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
require 'benchmark'

task :reload_json, [:file_name] => :environment do |_task, args|

  res = Benchmark.realtime do
    start_time = Time.now
    json = JSON.parse(File.read(args.file_name))

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      cities = {}
      buses = {}
      services = {}
      buses_services = {}
      trips = []
      p "1 #{Time.now - start_time}"
      json.each do |trip|
        from = cities[trip['from']] ||= City.new(name: trip['from'])
        to = cities[trip['to']] ||= City.new(name: trip['to'])

        bus = buses[trip['bus']['number']] ||= Bus.new(number: trip['bus']['number'], model: trip['bus']['model'])

        trip['bus']['services'].each do |service_name|
          s = services[service_name] ||= Service.new(name: service_name)
          buses_services[[bus, s]] ||= BusesService.new(bus:, service: s)
        end

        trips << Trip.new(
          from:,
          to:,
          bus:,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents']
        )
      end

      p "2 #{Time.now - start_time}"
      City.import! cities.values
      p "3 #{Time.now - start_time}"
      Bus.import! buses.values
      p "4 #{Time.now - start_time}"
      Service.import! services.values
      p "5 #{Time.now - start_time}"
      BusesService.import! buses_services.values
      p "6 #{Time.now - start_time}"
      Trip.import! trips
      p "7 #{Time.now - start_time}"
    end
  end

  p "Result Time #{res}"
end
