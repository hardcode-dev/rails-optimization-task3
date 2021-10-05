# frozen_string_literal: true

class Import
  def self.call(path)
    new(path).import
  end

  def initialize(path)
    @path = path
    @cities = {}
    @buses = {}
    @services = {}
    @buses_services = {}
    @trips = []
  end

  def import
    start_time = Time.now

    ActiveRecord::Base.transaction do
      clear_db
      import_services
      prepare_data
      save_data
    end

    puts "finish in #{Time.now - start_time}"
    puts "MEMORY USAGE: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
  end

  private

  def file
    JSON.parse(File.read(@path))
  end

  def clear_db
    City.delete_all
    Bus.delete_all
    ::Service.delete_all
    Trip.delete_all
    BusesService.delete_all
  end

  def prepare_data
    file.each do |trip|
      bus_key = "#{trip['bus']['model']}_#{trip['bus']['number']}"

      @cities[trip['from']] ||= City.new(name: trip['from'])
      @cities[trip['to']] ||= City.new(name: trip['to'])
      @buses[bus_key] ||= Bus.new( model: trip['bus']['model'], number: trip['bus']['number'] )

      unless @buses_services[@buses[bus_key]]
        trip['bus']['services'].each do |s|
          @buses_services[@buses[bus_key]] ||= []
          @buses_services[@buses[bus_key]] << @services[s]
        end
      end

      @trips << Trip.new(
        from: @cities[trip['from']],
        to: @cities[trip['to']],
        bus: @buses[bus_key],
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents'],
        )
    end
  end

  def import_services
    ::Service::SERVICES.each {|n| @services[n] = ::Service.new(name: n) }
    ::Service.import! @services.values
  end

  def save_data
    City.import! @cities.values
    Bus.import! @buses.values
    BusesService.import!(@buses_services.flat_map { |b, services| services.map! {|s| BusesService.new(bus: b, service: s) } })
    Trip.import! @trips
  end
end