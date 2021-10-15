# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/10M.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  DatabaseStreamWriter.new(args.file_name).write
end
