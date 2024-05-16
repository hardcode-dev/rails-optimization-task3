task :build_fixtures, [:file_name] => :environment do |_task, args|
  ::UtilsService.call("fixtures/#{args.file_name}.json")

  %i[cities buses services trips buses_services].each do |table_name|
    File.open("test/fixtures/files/#{args.file_name}_#{table_name}.json", 'w+') do |file|
      collection = ActiveRecord::Base.connection.execute("SELECT * FROM #{table_name} ORDER BY ID;").to_a.to_json
      file.write(collection)
    end
  end
end
