# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  file_path = args.file_name || "fixtures/large.json"

  JsonImporter.new.call(file_name: file_path)
end
