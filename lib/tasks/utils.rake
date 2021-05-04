task :reload_json, [:file_name, :size, :clear, :log] => :environment do |_task, args|
  log = ActiveModel::Type::Boolean.new.cast(args.log)
  if log
    BenchmarkService.monitoring('') do
      LoadScheduleService.new(args.file_name, args.size.to_i, log).call(
        ActiveModel::Type::Boolean.new.cast(args.clear))
    end
  else
    LoadScheduleService.new(args.file_name, args.size.to_i, log).call(
      ActiveModel::Type::Boolean.new.cast(args.clear))
  end
end
