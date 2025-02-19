require_relative '../benchmark/bench_wrapper'

task :reload_json, [:file_name] => :environment do |_task, args|
  measure do
    Reloader.reload(args.file_name)
  end
end
