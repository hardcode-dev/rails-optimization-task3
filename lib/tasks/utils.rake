task :reload_json, [:file_name] => :environment do |_task, args|
  ReloadJson.new(args.file_name).call
end
