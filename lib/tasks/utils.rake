# frozen_string_literal: true

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

desc 'Import data from .json files'
task :reload_json, [:file_name] => :environment do |_task, args|
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  class BusesService < ApplicationRecord; end
  # ActiveRecord::Base.logger = Logger.new STDOUT

  json = JSON.parse(File.read(args.file_name))

  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    cities = Set[]
    bus_numbers = Set[]
    buses = []
    buses_services_dict = {}
    trips = []

    services_batch_ids = Service.import [:name], Service::SERVICES.zip, validate: false
    services_ids = (Service::SERVICES.zip services_batch_ids.ids).to_h

    json.each do |trip|
      cities << trip['from']
      cities << trip['to']

      if bus_numbers.add?(trip['bus']['number'])
        buses << [trip['bus']['model'], trip['bus']['number']]
        buses_services_dict[trip['bus']['number']] = trip['bus']['services']
      end

      trips << [trip['from'], trip['to'], trip['bus']['number'],
                trip['start_time'], trip['duration_minutes'], trip['price_cents']]
    end

    cities_arr = cities.to_a
    city_batch_ids = City.import [:name], cities_arr.zip, validate: false
    city_ids = (cities_arr.zip city_batch_ids.ids).to_h

    buses_batch_ids = Bus.import %i[model number], buses, validate: false
    buses_ids = (buses.map { |bus| bus[1] }.zip buses_batch_ids.ids).to_h

    bus_services = []
    buses_services_dict.each do |bus_number, services|
      id = buses_ids[bus_number]
      services.each do |service|
        bus_services << [id, services_ids[service]]
      end
    end

    BusesService.import %i[bus_id service_id], bus_services, validate: false

    trips.map! { |trip| [city_ids[trip[0]], city_ids[trip[1]], buses_ids[trip[2]], trip[3], trip[4], trip[5]] }

    Trip.import %i[from_id to_id bus_id start_time duration_minutes price_cents], trips, validate: false
  end
end
