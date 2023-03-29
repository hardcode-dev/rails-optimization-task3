require_relative '_support/import_data_service'
# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  ImportDataService.new(args.file_name).call
end

