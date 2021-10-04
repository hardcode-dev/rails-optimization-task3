# frozen_string_literal: true

class JsonReloader
  def initialize(file_name)
    @file_name = file_name

    @services = {}
    @cities = {}
    @buses = {}
    @trips = []
  end

  def call
  	json = Oj.load(File.read(@file_name))

  	ActiveRecord::Base.transaction do
  	  delete_old_data

      add_new_data(json)
    end
  end

  private

  def delete_old_data
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end

  def add_new_data(json)
    json.each do |trip|
      from = get_city(@cities, trip['from'])
      to = get_city(@cities, trip['to'])
      
      calculate_bus_and_services(trip['bus'])

      trip = Trip.new(
        from: from,
        to: to,
        bus: @buses[trip['bus']['number']],
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents']
      )
      @trips << trip
    end

    Trip.import @trips
  end

  def get_city(cities, name)
	  if cities[name].nil?
      city = City.find_or_create_by(name: name)
      cities[name] = city
    else
      cities[name]
    end

    cities[name]
  end

  def calculate_bus_and_services(bus_object)
    if @buses[bus_object['number']].nil?
      bus_services = []
      bus_object['services'].each do |service|
        s = Service.find_or_create_by(name: service)
        bus_services << s
        @services[service] = s
      end

      bus = Bus.find_or_create_by(number: bus_object['number'], model: bus_object['model'], services: bus_services)
      @buses[bus_object['number']] = bus
    end
  end
end
