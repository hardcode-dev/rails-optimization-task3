# frozen_string_literal: true

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  ImportService.new(args.file_name).process
end
