# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

task :reload_json, [:file_name] => :environment do |_task, args|
  time_start = Time.current
  ImportTrips.new(args.file_name).call!
  puts "Total time: #{Time.current - time_start}"
end
