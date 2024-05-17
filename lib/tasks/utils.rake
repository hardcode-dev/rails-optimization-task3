task :reload_json, [:file_name] => :environment do |_task, args|
  time = Benchmark.realtime {
    ActiveRecord::Base.transaction do
      Service.delete_all
      Bus.delete_all
      Trip.delete_all
      BusesService.delete_all
      City.delete_all
    end

    Tasks::ImportJsonData.call(filepath: args.file_name)
  }

  puts "Total time is: #{time}"
end
