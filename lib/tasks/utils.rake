# frozen_string_literal: true

# Наивная загрузка данных из json-файла в БД
# rake reload_json[fixtures/small.json]
require 'importer'

namespace :utils do
  task :reload_json, [:file_name] => :environment do |_task, args|
    abort 'Send file path' unless args.file_name

    stream = File.open(args.file_name)

    Importer.call(stream)
  end
end
