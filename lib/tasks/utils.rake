task :reload_json, [:file_name] => :environment do |_task, args|
  JsonReloader.new(args.file_name).call
end
