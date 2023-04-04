# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  require Rails.root.join('lib/my_app/import')

  MyApp::Import.new(args.file_name, batch_size: ENV.fetch('BATCH_SIZE', 1000).to_i).call
end
