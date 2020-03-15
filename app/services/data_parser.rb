require 'set'

class DataParser < ::Oj::Saj
  attr_accessor :trips, :buses, :services, :cities, :buses_services

  def initialize(file)
    @file = file
    @array_cnt = 0
    @hash_cnt = 0
    @buses = Set.new
    @services = Service.all.map { |s| [s.name, s.id] }.to_h
    @buses_services = Set.new
    @cities = Set.new
    @trips = []
  end

  def call
    File.open(@file, 'r') { |f| Oj.saj_parse(self, f) }
  end

  def hash_start(key)
    @hash_cnt += 1

    @trip = {} if @hash_cnt == 1
    @bus = {} if @hash_cnt == 2
  end

  def hash_end(key)
    @hash_cnt -= 1

    if @hash_cnt == 1
      @buses << @bus
      @trip['bus_id'] = @bus
    end
    @trips << @trip if @hash_cnt == 0
  end

  def array_start(key)
    @array_cnt += 1
  end

  def array_end(key)
    @array_cnt -= 1
  end

  def add_value(value, key);
    # bus
    if @hash_cnt == 2 && @array_cnt == 1
      @bus[key] = value if key != 'services'
    end
    # service
    if @array_cnt == 2
      service = Service.find_by_name(value)
      @buses_services << { 'service_id' => @services[value], 'bus_id' => @bus }
    end
    # trip
    if @hash_cnt == 1
      @trip[key] = value unless %w[to from].include? key
      # city
      if %w[to from].include? key
        @cities << { 'name' => value }
        @trip["#{key}_id"] = { 'name' => value }
      end
    end
  end

  def error(message, line, column)
    puts "ERRRORRR: #{line}:#{column}: #{message}"
  end
end
