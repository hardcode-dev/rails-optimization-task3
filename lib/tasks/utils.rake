# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.measure do
    ImportService.new.call
  end

  puts time
end
