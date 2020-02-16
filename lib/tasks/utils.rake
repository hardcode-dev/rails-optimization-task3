# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

task :reload_json, [:file_name] => :environment do |_task, args|
  DbImport.call_with_benchmark { DbImport.import(filename = args.file_name) }
end
