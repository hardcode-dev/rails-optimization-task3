# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  require Rails.root.join('lib/my_app/import')

  MyApp::Import.new(args.file_name).call
end
