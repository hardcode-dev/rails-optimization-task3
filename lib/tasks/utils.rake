# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  BenchmarkUtil.memory_usage do
    BenchmarkUtil.realtime('Reload json') { ReloadJsonUtil.new(args.file_name).run }
  end
end
