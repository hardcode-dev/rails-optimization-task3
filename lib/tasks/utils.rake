# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
require_relative 'support/database_reloader'

task :reload_json, [:file_name] => :environment do |_task, args|
  DatabaseReloader.new(args.file_name).call
end

# Iteration 0: measurement for medium.json without any changes ~ 65 seconds
# Iteration 1: measurement for medium.json with batches and bulk import = 5.1 seconds
# Iteration 1: measurement for large.json with batches and bulk import = 17.6 seconds
