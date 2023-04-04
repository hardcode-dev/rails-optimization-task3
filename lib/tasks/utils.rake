require_relative '_support/import_data_service'
# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  puts "=> Import started"

  process_get_time = -> { Process.clock_gettime(Process::CLOCK_MONOTONIC) }
  start_time = process_get_time.call
  current_time = Time.current

  ImportDataService.new(args.file_name).call

  end_time = process_get_time.call
  elapsed_time = end_time - start_time
  min, sec = elapsed_time.divmod(60.0)

  puts "=> Import ended, took#{"%3d:%04.2f"%[min.to_i, sec]}"
  puts "Trips count: #{Trip.count}, Buses count: #{Bus.count}, Cities count: #{City.count}, Services count: #{Service.count}"
end
