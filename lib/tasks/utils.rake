# frozen_string_literal: true
require 'operations/import'
# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  Operations::Import.new.work(args.file_name)
end
