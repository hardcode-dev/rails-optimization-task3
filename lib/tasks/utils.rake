# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

require 'oj'

task :reload_json, [:file_name] => :environment do |_task, args|
  start_time = Time.now

  ImportData.new.call(args.file_name)

  puts "Done at #{Time.now - start_time} sec"
end

class ImportData
  BATCH_SIZE = 100

  attr_reader :cities, :services, :buses, :buses_services, :trips

  def initialize
    @cities = {}
    @services = {}
    @buses = {}
    @buses_services = {}
    @trips = []
  end

  def call(path)
    import!(path)
  end

  private

  def import!(path)
    json = Oj.load(File.read(path), symbol_keys: false)

    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      BusesService.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')

      json.each do |trip|
        cities[trip['from']] ||= City.find_or_create_by(name: trip['from'])
        cities[trip['to']] ||= City.find_or_create_by(name: trip['to'])
        buses[trip['bus']['number']] ||= Bus.find_or_create_by(number: trip['bus']['number'], model: trip['bus']['model'])

        trip['bus']['services'].each do |service|
          services[service] ||= Service.find_or_create_by(name: service)
          buses_services["#{buses[trip['bus']['number']].id}_#{services[service].id}"] ||=
            BusesService.find_or_create_by(bus: buses[trip['bus']['number']], service: services[service])
        end

        trips << Trip.new(
          from: cities[trip['from']],
          to: cities[trip['to']],
          bus: buses[trip['bus']['number']],
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        )

        if trips.size == BATCH_SIZE
          Trip.import!(trips)
          @trips = []
        end
      end

      Trip.import!(trips) if trips.any?
    end
  end
end
