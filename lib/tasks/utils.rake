require_relative '../json_importer'

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  JSONImporter.call(args.file_name)
end
