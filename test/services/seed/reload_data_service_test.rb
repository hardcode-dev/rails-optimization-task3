require 'test_helper'

class Seed::ReloadDataServiceTest < ActiveSupport::TestCase
  def setup
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
    ActiveRecord::Base.connection.execute('delete from buses_services;')

    @data_file_path = Rails.root.join('fixtures', 'small.json')
  end

  test 'regress test' do
    assert_equal City.count, 0
    assert_equal Bus.count, 0
    assert_equal Service.count, 0
    assert_equal Trip.count, 0

    Seed::ReloadDataService.new(@data_file_path).call

    assert_equal City.count, 10
    assert_equal Bus.count, 613
    assert_equal Bus.all.pluck(:model).uniq.size, 10
    assert_equal Service.count, 10
    assert_equal Trip.count, 1000
    assert_equal Trip.all.sum(:price_cents), 49_049_033
  end

  test 'performance test' do
    benchmark_with_limit 800 do
      Seed::ReloadDataService.new(@data_file_path).call
    end
  end

  # test 'big performance test' do
  #   big_data_file_path = Rails.root.join('fixtures', 'large.json')
  #
  #   benchmark_with_limit 55_000 do
  #     Seed::ReloadDataService.new(big_data_file_path).call
  #   end
  # end
end
