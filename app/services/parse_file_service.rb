# frozen_string_literal: true

require 'oj'
# Parse JSON file and save data to DB
class ParseFileService
  BATCH_SIZE = 10_000

  def initialize(file_name)
    @file_name = file_name
    @cities = {}
    @trips = []

  end

  def call
    ActiveRecord::Base.transaction do
      clean_db
      import_services
      parse_file
    end
  end

  private

  def parse_file
    json = Oj.load(File.read(@file_name))
    init_progressbar(json.size)
    while json.any?
      create_trip(json.shift)
      @progressbar.increment
      if @trips.length == BATCH_SIZE
        import_to_db
        @trips = []
      end
    end
    import_to_db
  end

  def clean_db
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusesService.delete_all
  end

  def import_services
    new_services = Service::SERVICES.map do |name|
      Service.new(name: name)
    end
    Service.import(new_services)
  end

  def services
    @services ||= Service.all.index_by(&:name)
  end

  def find_or_create_city(city)
    @cities[city] ||= City.create(name: city)
  end

  def create_bus(trip)
    bus_services = trip['bus']['services'].map { |service| services[service] }.compact
    bus = Bus.find_by(number: trip['bus']['number'])
    bus ||= Bus.create(number: trip['bus']['number'], model: trip['bus']['model'], services: bus_services)
  end

  def create_trip(trip)
    @trips << Trip.new(start_time: trip['start_time'],
                       duration_minutes: trip['duration_minutes'],
                       price_cents: trip['price_cents'],
                       from: find_or_create_city(trip['from']),
                       to: find_or_create_city(trip['to']),
                       bus: create_bus(trip))
  end

  def import_to_db
    Trip.import @trips
  end

  def init_progressbar(size)
    @progressbar = ProgressBar.create(
      total: size,
      format: '%a, %J, %E, %B'
    )
  end
end
