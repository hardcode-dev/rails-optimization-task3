require 'ruby-prof'

GC.disable

RubyProf.measure_mode = RubyProf::WALL_TIME
RubyProf.start

ImportTrips::ParseJsonService.call(file_path: 'fixtures/example.json')

results = RubyProf.stop

File.open 'reports/profile-graph.html', 'w' do |file|
  RubyProf::GraphHtmlPrinter.new(results).print(file)
end

File.open 'reports/profile-flat.txt', 'w' do |file|
  RubyProf::FlatPrinter.new(results).print(file)
end

RubyProf::CallTreePrinter.new(results).print(path: 'reports', profile: 'profile')
