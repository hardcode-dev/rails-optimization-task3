# frozen_string_literal: true

require_relative '../test_helper'
require 'minitest/autorun'
require 'populate_database'

class PopulateDatabaseTest < Minitest::Test

  def teardown
    City.delete_all
    Bus.delete_all
    Service.delete_all
    Trip.delete_all
  end

  def test_call_populates_db_with_correct_data
    PopulateDatabase.call(file_path: 'fixtures/example.json')

    assert_equal %w[Москва Самара], City.pluck(:name).sort
    assert_equal [%w[123 Икарус]], Bus.pluck(:number, :model)
    assert_equal %w[WiFi Туалет], Service.pluck(:name).sort
    assert_equal %w[11:00 12:00 13:00 14:00 15:00 17:30 18:30 19:30 20:30 21:30], Trip.pluck(:start_time).sort
  end

  def test_call_populates_db_with_correct_references
    PopulateDatabase.call(file_path: 'fixtures/example.json')

    bus = Bus.take
    trip = Trip.take

    assert_equal 2, bus.services.count
    assert_equal 10, bus.trips.count
    assert_equal 1, Service.take.buses.count
    assert_instance_of City, trip.from
    assert_instance_of City, trip.to
    assert_instance_of Bus, trip.bus
  end

  def test_call_is_idempotent
    PopulateDatabase.call(file_path: 'fixtures/example.json')
    PopulateDatabase.call(file_path: 'fixtures/example.json')

    assert_equal 2, City.count
    assert_equal 1, Bus.count
    assert_equal 2, Service.count
    assert_equal 10, Trip.count
  end
end
