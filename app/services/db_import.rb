module DbImport
  module_function

  def call_with_benchmark
    time = Benchmark.measure do
      yield
    end
    puts "Runtime: #{time.real.round(2)} seconds | MEMORY USAGE: %d MB" % (`ps -o rss= -p #{Process.pid}`.to_i / 1024)
  end

  def import(filename = 'fixtures/medium.json')
    data = File.join(Rails.root, "#{filename}")
    json = JSON.parse(File.read(data))

    ActiveRecord::Base.transaction do
      City.clear
      Bus.clear
      Service.clear
      Trip.clear
      ActiveRecord::Base.connection.execute('TRUNCATE TABLE buses_services;')

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
  end
end
