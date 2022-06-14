task :reload_json, [:file_name] => :environment do |_task, args|
  ReloadSchedule.call(file_name: args.file_name)
end

