# Загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  ActiveRecord::Base.logger = Logger.new STDOUT
  Importer.new(args.file_name).perform
end

task :benchmark, [:file_name] => :environment do |_task, args|
  ActiveRecord::Base.logger = Logger.new STDOUT
  Benchmark.bm do |x|
    x.report { Importer.new(args.file_name).perform }
  end
end

task :memory_callgrind, [:file_name] => :environment do |_task, args|
  Importer.new(args.file_name).perform('memory_callgrind')
end

task :time_callgrind, [:file_name] => :environment do |_task, args|
  Importer.new(args.file_name).perform('time_callgrind')
end
