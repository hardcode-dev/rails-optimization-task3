require_relative '../test_helper'

class UtilsServiceTest < ActiveSupport::TestCase
  setup do
    ::UtilsService.call('fixtures/small.json')
  end

  test 'validates exported data' do
    ::UtilsService::TABLE_NAMES.each do |table_name|
      collection = ActiveRecord::Base.connection.execute("select * from #{table_name} order by id;").to_a
      assert_equal(collection, JSON.parse(File.read("#{Rails.root}/test/fixtures/files/small_#{table_name}.json")))
    end
  end
end
