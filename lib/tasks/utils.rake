# rake reload_json[fixtures/small.json]
task :reload_json, [:file_name] => :environment do |_task, args|
  ActiveRecord::Base.transaction do
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    DataLoader.new(args.file_name).call
  end
end
