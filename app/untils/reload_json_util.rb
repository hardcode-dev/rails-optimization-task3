# frozen_string_literal: true

class ReloadJsonUtil
  attr_reader :file_name
  def initialize(file_name)
    @file_name = file_name

    @cities = {}
    @services = {}
    @buses = {}
    @bus_services = {}
    @trips = []
  end

  def clear_db
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    %i[buses buses_services cities services trips].each do |table|
      ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end

  def city(name)
    @cities[name] ||= City.new(name: name)
  end

  def bus(number, model)
    @buses[number] ||= Bus.new(number: number, model: model)
  end

  def services
    @services ||= Service.all.pluck(:name, :id).to_h
  end

  def bus_service(bus, service_name)
    service_id = services[service_name]
    key = [bus.number, service_id]
    @bus_services[key] ||= BusesService.new(bus: bus, service_id: service_id)
  end

  def import_services
    res = Service.import([:name], Service::SERVICES.map { |n| [n] }, validate: false)
    @services = Service::SERVICES.zip(res.ids).to_h
  end

  def run
    json = JSON.parse(File.read(file_name))

    ActiveRecord::Base.transaction do
      clear_db
      import_services

      json.each do |trip|
        from = city(trip['from'])
        to   = city(trip['to'])
        bus  = bus(trip['bus']['number'], trip['bus']['model'])

        trip['bus']['services'].each do |service_name|
          bus_service(bus, service_name)
        end

        @trips << Trip.new(
          from: from,
          to: to,
          bus: bus,
          start_time: trip['start_time'],
          duration_minutes: trip['duration_minutes'],
          price_cents: trip['price_cents'],
        )
      end
      City.import @cities.values
      Bus.import @buses.values

      BusesService.import @bus_services.values
      Trip.import @trips
    end
  end
end
