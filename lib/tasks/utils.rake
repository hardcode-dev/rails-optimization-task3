# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

task :reload_json, [:file_name] => :environment do |_task, args|
  start_time = Time.current

  TripsImporter.call(args.file_name)

  end_time = Time.current

  p end_time - start_time
end
