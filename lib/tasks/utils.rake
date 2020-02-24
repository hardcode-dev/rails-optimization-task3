require 'benchmark'

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.realtime do
    ImportData.new(args.file_name).exec
  end

  puts "Finish in #{time.round(2)}"
end
