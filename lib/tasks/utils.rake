# frozen_string_literal: true

require 'populate_database'

desc 'Loads datum from *.json dump file to DB'
task :reload_json, [:file_path] => :environment do |_task, args|
  PopulateDatabase.call(file_path: args.file_path)
end
