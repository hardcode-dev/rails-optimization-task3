# frozen_string_literal: true
require 'activerecord-import'

class ImportData < ActiveInteraction::Base
  string :file_name

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
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end

  def import_data
    json = JSON.parse(File.read(file_name))

    trips = []

    json.each do |trip|
      trips << trip_new(trip)
      print '.'
    end

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
    City.find_or_create_by(name: name)
  end

  def fetch_bus(trip)
    bus = Bus.find_or_create_by(number: trip['bus']['number'])
    bus.update(model: trip['bus']['model'], services: fetch_bus_services(trip))
    bus
  end

  def fetch_bus_services(trip)
    trip['bus']['services'].map do |service|
      Service.find_or_create_by(name: service)
    end
  end

  def print_memory_usage
    puts "MEMORY USAGE: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
  end
end