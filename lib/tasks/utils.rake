task :reload_json, [:file_name, :size, :clear] => :environment do |_task, args|
  BenchmarkService.monitoring('') do
    LoadScheduleService.new(args.file_name).call(
      clear = ActiveModel::Type::Boolean.new.cast(args.clear), 
      size = args.size.to_i)
  end
end
