# frozen_string_literal: true

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.realtime do
    ReloadTripsDataService.new(args.file_name).call
  end
  puts "Benchmark realtime: #{time}"
end
