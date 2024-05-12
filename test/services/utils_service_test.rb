require_relative '../test_helper'

class UtilsServiceTest < ActiveSupport::TestCase

  ::UtilsService.call('fixtures/example.json')

  ::UtilsService::TABLE_NAMES.each do |table_name|
    test "validates #{table_name} data" do
      collection = ActiveRecord::Base.connection.execute("select * from #{table_name} order by id;").to_a
      assert_equal(collection, JSON.parse(File.read("#{Rails.root}/test/fixtures/files/example_#{table_name}.json")))
    end
  end
end
