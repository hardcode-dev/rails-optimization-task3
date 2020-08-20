require 'byebug'

class Seed::ReloadDataService
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    upload
  end

  private

  def upload
    @json = JSON.parse(File.read(file_name))

    ActiveRecord::Base.transaction do
      clear_data
      load_trips
    end
  end

  def clear_data
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end

  def load_trips
    Service.import(Service::SERVICES.map { |s| Service.new(name: s) })
    @service_cache = {}
    Service.all.each { |service| @service_cache[service.name] = service.id }

    trips = []
    @city_cache = {}
    @bus_cache = {}
    @bus_service_cache = {}

    @json.each do |data|
      trip = {
        start_time: data['start_time'],
        duration_minutes: data['duration_minutes'],
        price_cents: data['price_cents']
      }

      @city_cache[data['from']] = { name: data['from'] } unless @city_cache[data['from']]
      @city_cache[data['to']] = { name: data['to'] } unless @city_cache[data['to']]

      bus_key = "#{data['bus']['model']}_#{data['bus']['number']}"
      unless @bus_cache[bus_key]
        @bus_cache[bus_key] = { model: data['bus']['model'], number: data['bus']['number'] }
      end

      data['bus']['services'].each do |service|
        @bus_service_cache[bus_key] ||= []
        @bus_service_cache[bus_key] << @service_cache[service]
      end

      trip[:from_id] = data['from']
      trip[:to_id] = data['to']
      trip[:bus_id] = bus_key

      trips << trip
    end

    city_import_result = City.import(@city_cache.values, raise_error: true)
    bus_import_result = Bus.import(@bus_cache.values, raise_error: true)

    bservices = []
    @bus_service_cache.each do |bus_key, service_ids|
      bus_id = bus_import_result.ids[@bus_cache.keys.index(bus_key)]
      service_ids.each { |sid| bservices << { bus_id: bus_id, service_id: sid } }
    end

    BusesService.import(bservices, raise_error: true, on_duplicate_key_ignore: true)

    trips.each do |trip|
      trip[:from_id] = city_import_result.ids[@city_cache.keys.index(trip[:from_id])]
      trip[:to_id] = city_import_result.ids[@city_cache.keys.index(trip[:to_id])]
      trip[:bus_id] = bus_import_result.ids[@bus_cache.keys.index(trip[:bus_id])]
    end

    Trip.import(trips, raise_error: true)
  end
end
