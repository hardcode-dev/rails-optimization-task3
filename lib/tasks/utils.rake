# frozen_string_literal: true

require_relative 'initial_seed_service'

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  InitialSeedService.call(args.file_name)
end
