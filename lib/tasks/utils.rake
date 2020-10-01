# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  BenchmarkUtil.memory_usage do
    BenchmarkUtil.realtime('Reload json') { ReloadJsonStreamUtil.new(args.file_name).run }
  end
end

task reload_json_stream: :environment do
  BenchmarkUtil.memory_usage do
    # params = ['fixtures/mega.json', 1_000_000]
    params = ['fixtures/hardcore.json', 10_000_000]
    BenchmarkUtil.realtime('Reload json') { ReloadJsonStreamUtil.new(*params).run }
  end
end
