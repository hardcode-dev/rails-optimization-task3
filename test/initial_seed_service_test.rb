# frozen_string_literal: true

require 'test_helper'
require Rails.root.join('lib/tasks/initial_seed_service')

class ReloadJsonTaskTest < ActiveSupport::TestCase
  test 'task on large data is finished less than 10 sec' do
    file_name = 'fixtures/large.json'
    time = Benchmark.realtime do |_x|
      InitialSeedService.call(file_name)
    end

    puts "Finish in #{time.round(2)}"

    assert time <= 10
  end

  test 'task updates database correctly' do
    file_name = 'fixtures/example.json'
    InitialSeedService.call(file_name)
    random_trip =
      {
        from: City.find_by(name: 'Самара'),
        to: City.find_by(name: 'Москва'),
        start_time: '17:30',
        duration_minutes: 37,
        price_cents: 173,
        bus: Bus.find_by(number: 123)
      }

    assert Trip.find_by(random_trip)
    assert 10, Trip.count
    assert 2, City.count
    assert 1, Bus.count
    assert 2, Service.count
  end
end
