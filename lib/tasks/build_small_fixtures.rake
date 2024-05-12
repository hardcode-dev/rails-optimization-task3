task build_small_fixtures: :environment do
  ::UtilsService.call('fixtures/small.json')

  %i[cities buses services trips buses_services].each do |table_name|
    File.open("test/fixtures/files/small_#{table_name}.json", 'w+') do |file|
      collection = ActiveRecord::Base.connection.execute("SELECT * FROM #{table_name} ORDER BY ID;").to_a.to_json
      file.write(collection)
    end
  end
end
