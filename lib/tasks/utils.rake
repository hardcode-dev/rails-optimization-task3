# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

desc 'Загрузка данных из файла'
task :reload_json, [:file_name] => :environment do |_task, args|
  time1 = Time.now
  TripsLoad.perform(args.file_name)
  puts "Imported in #{Time.now - time1}"
end
