# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  ImportTrips::ParseJsonService.call(file_path: args.file_name)
end

task :reload_stream_json, [:file_name] => :environment do |_task, args|
  ImportTrips::ParseStreamJsonService.new(file_path: args.file_name).call
end
