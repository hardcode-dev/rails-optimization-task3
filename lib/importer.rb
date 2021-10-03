class Importer

  def initialize(filename)
    @filename = filename || 'fixtures/small.json'
    @cities = {}
    @services = {}
    @buses = {}
  end

  def perform(profiler = nil)
    ActiveRecord::Base.transaction do
      flush_all
      case profiler
      when 'memory_callgrind'
        memory_callgrind_import
      when 'time_callgrind'
        time_callgrind_import
      else
        import
      end
    end
  end

  private

  def flush_all
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    BusesService.delete_all
  end

  def import
    json = JSON.parse(File.read(@filename))

    json.each do |trip|
      # Collect cities
      @cities[trip['from']] ||= City.create(name: trip['from']).id
      @cities[trip['to']] ||= City.create(name: trip['to']).id

      # Collect bus and its services
      unless @buses[trip['bus']['number']]
        service_ids = trip['bus']['services'].map do |service_name|
          @services[service_name] ||= Service.create(name: service_name).id
        end

        @buses[trip['bus']['number']] = Bus.create(number: trip['bus']['number'], model: trip['bus']['model']).id

        service_ids.each do |service_id|
          BusesService.create(bus_id: @buses[trip['bus']['number']], service_id: service_id)
        end
      end

      # Create trip
      Trip.create!(
        from_id: @cities[trip['from']],
        to_id: @cities[trip['to']],
        bus_id: @buses[trip['bus']['number']],
        start_time: trip['start_time'],
        duration_minutes: trip['duration_minutes'],
        price_cents: trip['price_cents'],
        )
    end
  end

  def memory_callgrind_import
    RubyProf.measure_mode = RubyProf::MEMORY
    result = RubyProf.profile { import }
    RubyProf::CallTreePrinter.new(result).print(path: 'reports', profile: 'memory_callgrind')
  end

  def time_callgrind_import
    RubyProf.measure_mode = RubyProf::WALL_TIME
    result = RubyProf.profile { import }
    RubyProf::CallTreePrinter.new(result).print(path: 'reports', profile: 'time_callgrind')
  end

end
