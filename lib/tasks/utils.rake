# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
require 'ruby-progressbar'
require 'benchmark'
require 'ruby-prof'
require 'pry'

def work json
  ActiveRecord::Base.transaction do
    json.each do |trip|
      # вот эти 2 запроса можно объединить в один запрос с IN || OR
      # но это не главная точка роста
      from = City.find_or_create_by(name: trip['from'])
      to = City.find_or_create_by(name: trip['to'])
      services = []
      trip['bus']['services'].each do |service|
        services << service
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
      $progressbar.increment
    end
  end
  #puts "Time to update buses: #{update_buses_time}"
end

task :reload_json, [:file_name] => :environment do |_task, args|
  Bullet.enable = true
  Bullet.bullet_logger = true
  json = JSON.parse(File.read(args.file_name))
  #File.write('./fixtures/tiny.json', json[0..100].to_json); exit(0)

  $progressbar = ProgressBar.create(
    total: json.size,
    format: '%a, %J, %E, %B'
  )
  
  time = Benchmark.realtime do
    ActiveRecord::Base.transaction do
      City.delete_all
      Bus.delete_all
      Service.delete_all
      Trip.delete_all
      ActiveRecord::Base.connection.execute('delete from buses_services;')
    end
  end
  puts "RealTime deleting: #{time}"

  #RubyProf.measure_mode = RubyProf::WALL_TIME
  RubyProf.measure_mode = RubyProf::ALLOCATIONS
  result = nil
  
  realtime = Benchmark.realtime do
    GC.disable
    work(json)
  end
  puts "RealTime: #{realtime}"

=begin
    exit(0)
    result = RubyProf.profile do 
      GC.disable
      work(json)
    end
    if result 
      printer = RubyProf::GraphHtmlPrinter.new(result)
      printer.print(File.open('prof_reports/graph.html', 'w+'))
      system('open', 'prof_reports/graph.html')
    end
=end
end
