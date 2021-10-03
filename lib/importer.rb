class Importer

  def initialize(filename)
    @filename = filename || 'fixtures/small.json'
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
    ActiveRecord::Base.connection.execute('delete from buses_services;')
  end

  def import
    json = JSON.parse(File.read(@filename))

    json.each do |trip|
      from = City.find_or_create_by(name: trip['from'])
      to = City.find_or_create_by(name: trip['to'])
      services = []
      trip['bus']['services'].each do |service|
        s = Service.find_or_create_by(name: service)
        services << s
      end
      bus = Bus.find_or_create_by(number: trip['bus']['number'])
      bus.update(model: trip['bus']['model'], services: services)

      Trip.create!(
        from: from,
        to: to,
        bus: bus,
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
