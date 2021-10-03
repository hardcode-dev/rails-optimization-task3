# Загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  filename = args.file_name || 'fixtures/example.json'
  Importer.perform(filename)
end

task :benchmark, [:file_name] => :environment do |_task, args|
  filename = args.file_name || 'fixtures/small.json'
  Benchmark.bm do |x|
    x.report { Importer.perform(filename) }
  end
end

task :callgrind_time, [:file_name] => :environment do |_task, args|
  filename = args.file_name || 'fixtures/small.json'
  RubyProf.measure_mode = RubyProf::WALL_TIME

  result = RubyProf.profile { Importer.perform(filename) }

  printer = RubyProf::CallTreePrinter.new(result)
  printer.print(path: 'reports', profile: 'time_callgrind')
end

task :callgrind_memory, [:file_name] => :environment do |_task, args|
  filename = args.file_name || 'fixtures/small.json'
  RubyProf.measure_mode = RubyProf::MEMORY

  result = RubyProf.profile { Importer.perform(filename) }

  printer = RubyProf::CallTreePrinter.new(result)
  printer.print(path: 'reports', profile: 'memory_callgrind')
end

task :valgrind, [:file_name] => :environment do |_task, args|
  filename = args.file_name || 'fixtures/small.json'

  sh "valgrind --tool=massif --massif-out-file=./reports/massif.out rake reload_json[#{filename}]"
end
