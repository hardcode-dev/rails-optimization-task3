# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|

  time = Benchmark.realtime do
    JsonFileToDbProcessor.new(args.file_name).call
  end

  puts "... processed #{args.file_name} in #{time} sec"
  puts "Used #{`ps -o rss= -p #{Process.pid}`.to_i / 1024} Mb Ram"
end


task :reload_json_profile, [:file_name] => :environment do |_task, args|
  RubyProf.measure_mode = RubyProf::WALL_TIME

  result = RubyProf.profile do
    JsonFileToDbProcessor.new(args.file_name).call
  end

  printer4 = RubyProf::CallTreePrinter.new(result)
  printer4.print(:path => "ruby_prof_reports", :profile => 'callgrind')

  puts "Used #{`ps -o rss= -p #{Process.pid}`.to_i / 1024} Mb Ram"
end