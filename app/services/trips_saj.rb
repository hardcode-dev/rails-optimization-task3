# frozen_string_literal: true

class TripsSaj < ::Oj::Saj
  BATCH_SIZE = 10_000

  def initialize
    @trip_cnt = 0
    @all_services = Service::SERVICES.map { |s| [s, Service.create(name: s).id] }.to_h
    @buses = {}
    @cities = {}
    @trips = []
    @trip = {}
    @valid = true
    @new_bus = false
    @model = nil
    @number = nil
    @array_count = 0
  end

  def array_start(key)
    @array_count += 1
  end

  def array_end(key)
    @array_count -= 1
    if @array_count.zero?
      Trip.bulk_import(@trips) if @trips.any?
      @buses.each do |_key, values|
        BusesService.bulk_import(values[:services].map { |service_id| { bus_id: values[:id], service_id: service_id } })
      end
    end
  end

  def hash_start(key)
    @model = nil
    @number = nil
    @new_bus = false
    @trip_cnt += 1 if key == 'bus'
  end

  def add_value(value, key)
    case key
    when 'model'
      @model = value
      init_bus
    when 'number'
      @number = value
      init_bus
    when nil
      @buses["#{@number}#{@model}"][:services] << @all_services[value] if @new_bus
    when 'duration_minutes'
      @trip[:duration_minutes] = value
    when 'start_time'
      @trip[:start_time] = value
    when 'price_cents'
      @trip[:price_cents] = value
    when 'from'
      if value.include?(' ')
        @valid = false
      else
        @cities[value] ||= City.create(name: value).id
        @trip[:from_id] = @cities[value]
      end
      insert_trips
    when 'to'
      if value.include?(' ')
        @valid = false
      else
        @cities[value] ||= City.create(name: value).id
        @trip[:to_id] = @cities[value]
      end
      insert_trips
    end
  end

  private

  def insert_trips
    return if @trip[:from_id].blank? || @trip[:to_id].blank?

    if @valid
      init_bus if @trip[:bus_id].blank?
      @trips << @trip if @trip && @trip[:bus_id].present?
    end
    @trip = {}
    @model = nil
    @number = nil
    @valid = true
    if @trips.any? && (@trip_cnt % BATCH_SIZE).zero?
      Trip.bulk_import(@trips)
      @trips = []
    end
  end

  def init_bus
    return if @number.blank? || @model.blank?

    bus_key = "#{@number}#{@model}"
    if @buses[bus_key].present?
      @trip[:bus_id] = @buses[bus_key][:id]
    else
      @buses[bus_key] = {}
      @buses[bus_key][:id] = Bus.create(model: @model, number: @number).id
      @buses[bus_key][:services] = []
      @new_bus = true
    end
  end
end
