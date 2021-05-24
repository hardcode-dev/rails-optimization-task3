# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]

task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.realtime do
    Jobs::Import::TripsJob.new(args.file_name, progressbar: true).call
  end
  puts "Trips import realtime: #{time}"
end
