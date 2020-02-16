# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
desc 'Import data'
task :reload_json, [:file_name] => :environment do |_task, args|
  import = RunBenchmark.call { DbImport.import(args.file_name) }
  p "Summary: DURATION in sec = #{import[:runtime_sec]}, MEMORY usage = #{import[:memory_mb]} MB"
end
