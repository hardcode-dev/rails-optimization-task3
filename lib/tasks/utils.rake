# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
require 'benchmark'

task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.realtime do
    ReloadJson.call(args.file_name)
  end

  puts "Finish in #{time.round(2)}"
end
