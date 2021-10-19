# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

task :reload_json, [:file_name] => :environment do |_task, args|
  JsonImporter.perform(args.file_name)
end

task :profile, [:file_name] => :environment do |_task, args|
  require 'ruby-prof'
  RubyProf.measure_mode = RubyProf::ALLOCATIONS

  result = RubyProf.profile do
    JsonImporter.perform(args.file_name)
  end

  # print a graph profile to text
  printer = RubyProf::FlatPrinter.new(result)
  printer.print(STDOUT, {})
end

task :memory_profile, [:file_name] => :environment do |_task, args|
  require 'memory_profiler'

  report = MemoryProfiler.report do
    JsonImporter.perform(args.file_name)
  end

  report.pretty_print
end

task :benchmark, [:file_name] => :environment do |_task, args|
  Benchmark.bm do |x|
    x.report { JsonImporter.perform(args.file_name) }
  end
end
