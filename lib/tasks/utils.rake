# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
desc 'Reload data from json file'
task :reload_json, [:file_name] => :environment do |_task, args|
  DataLoader.load(args.file_name)
end
