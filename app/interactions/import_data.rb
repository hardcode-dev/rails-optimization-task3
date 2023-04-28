# frozen_string_literal: true
require 'fast_jsonparser'

class ImportData < ActiveInteraction::Base
  string :file_name

  attr_reader :trips, :services, :buses, :cities

  def execute
    start_time = Time.now

    ActiveRecord::Base.transaction do
      drop_data
      import_data
    end

    puts "\nFinished! Time: #{Time.now - start_time}"
    print_memory_usage
  end

  private

  def drop_data
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusesService.delete_all
  end

  def import_data
    @trips = []
    @buses = {}
    @services = {}
    @cities = {}

    json = FastJsonparser.parse(File.read(file_name), symbolize_keys: false)

    json.each do |trip|
      trips << trip_new(trip)
      print '.'
    end

    Service.import services.values
    Bus.import buses.values, recursive: true
    City.import cities.values
    Trip.import trips
  end

  def trip_new(trip)
    Trip.new(
      from: fetch_city(trip['from']),
      to: fetch_city(trip['to']),
      bus: fetch_bus(trip),
      start_time: trip['start_time'],
      duration_minutes: trip['duration_minutes'],
      price_cents: trip['price_cents'],
    )
  end

  def fetch_city(name)
    cities[name] ||= City.new(name: name)
  end

  def fetch_bus(trip)
    bus = buses[trip['bus']['number']]
    return bus if bus

    buses[trip['bus']['number']] =
      Bus.new(
        number: trip['bus']['number'],
        model: trip['bus']['model'],
        services: fetch_bus_services(trip)
      )
  end

  def fetch_bus_services(trip)
    trip['bus']['services'].map do |service|
      services[service] ||= Service.new(name: service)
    end
  end

  def print_memory_usage
    puts "MEMORY USAGE: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
  end
end