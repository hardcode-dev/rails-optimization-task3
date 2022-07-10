require 'ruby-prof'
require_relative 'support/trips_reloader'

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  TripsReloader.new(JSON.parse(File.read(args.file_name))).call
end
