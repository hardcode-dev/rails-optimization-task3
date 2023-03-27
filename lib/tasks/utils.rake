require 'data_import'

# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  DataImport.new(args.file_name).call
end

