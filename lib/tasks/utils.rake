# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.realtime do
    ReloadSchedule.call(file_name: args.file_name, gc_disabled: false)
  end

  puts "Benchmark time #{time}"
end
