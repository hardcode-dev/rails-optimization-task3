# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.realtime do
    ReloadJsonService.new(args).run
  end

  puts "Finish in #{time.round(2)}"
end

task :reload_json_stream, [:file_name, :count] => :environment do |_task, args|
  ReloadJsonServiceStream.new(args).run
end

task :reload_json_profiler, [:file_name] => :environment do |_task, args|
  report = MemoryProfiler.report do
    ReloadJsonService.new(args).run
  end

  report.pretty_print(scale_bytes: true)
end


task :reload_json_rubyprof, [:file_name] => :environment do |_task, args|
  RubyProf.measure_mode = RubyProf::ALLOCATIONS

  result = RubyProf.profile do
    ReloadJsonService.new(args).run
  end

  printer = RubyProf::GraphHtmlPrinter.new(result)
  printer.print(File.open('ruby_prof_graph.html', 'w+'))

  printer = RubyProf::CallStackPrinter.new(result)
  printer.print(File.open('ruby_prof_callstack.html', 'w+'))
end

task :reload_json_cpu, [:file_name] => :environment do |_task, args|
  RubyProf.measure_mode = RubyProf::WALL_TIME

  result = RubyProf.profile do
    ReloadJsonService.new(args).run
  end

  printer = RubyProf::GraphHtmlPrinter.new(result)
  printer.print(File.open("/ruby_prof_graph.html", "w+"))
end

