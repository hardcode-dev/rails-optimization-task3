# frozen_string_literal: true

require 'test_helper'

class ReloadJsonUtilTest < ActiveSupport::TestCase
  test 'reload example.json is correct' do
    ReloadJsonUtil.new('fixtures/example.json').run

    assert_equal %w[Москва Самара], City.order(:name).pluck(:name)
    assert_equal [%w[123 Икарус]], Bus.pluck(:number, :model)
    assert_equal %w[WiFi Туалет], Bus.last.services.order(:name).pluck(:name)
    # assert_equal %w[WiFi Туалет], Service.order(:name).pluck(:name)

    options = {
      only: %i[start_time duration_minutes price_cents],
      include: {
        bus: { only: %i[number model] },
        from: { only: :name },
        to: { only: :name },
      }
    }

    exp_json = <<~JSON
      [
        {"start_time":"11:00","duration_minutes":168,"price_cents":474,
          "bus":{"number":"123","model":"Икарус"},"from":{"name":"Москва"},"to":{"name":"Самара"}},
        {"start_time":"12:00","duration_minutes":323,"price_cents":672,
          "bus":{"number":"123","model":"Икарус"},"from":{"name":"Москва"},"to":{"name":"Самара"}},
        {"start_time":"13:00","duration_minutes":304,"price_cents":641,
          "bus":{"number":"123","model":"Икарус"},"from":{"name":"Москва"},"to":{"name":"Самара"}},
        {"start_time":"14:00","duration_minutes":598,"price_cents":629,
          "bus":{"number":"123","model":"Икарус"},"from":{"name":"Москва"},"to":{"name":"Самара"}},
        {"start_time":"15:00","duration_minutes":127,"price_cents":795,
          "bus":{"number":"123","model":"Икарус"},"from":{"name":"Москва"},"to":{"name":"Самара"}},
        {"start_time":"17:30","duration_minutes":37,"price_cents":173,
          "bus":{"number":"123","model":"Икарус"},"from":{"name":"Самара"},"to":{"name":"Москва"}},
        {"start_time":"18:30","duration_minutes":315,"price_cents":969,
          "bus":{"number":"123","model":"Икарус"},"from":{"name":"Самара"},"to":{"name":"Москва"}},
        {"start_time":"19:30","duration_minutes":21,"price_cents":663,
          "bus":{"number":"123","model":"Икарус"},"from":{"name":"Самара"},"to":{"name":"Москва"}},
        {"start_time":"20:30","duration_minutes":292,"price_cents":22,
          "bus":{"number":"123","model":"Икарус"},"from":{"name":"Самара"},"to":{"name":"Москва"}},
        {"start_time":"21:30","duration_minutes":183,"price_cents":846,
          "bus":{"number":"123","model":"Икарус"},"from":{"name":"Самара"},"to":{"name":"Москва"}}
      ]
    JSON
    act_trips = Bus.last.trips.preload(:from, :to).order(:start_time).as_json(options)
    assert_equal JSON.parse(exp_json), act_trips

    options
  end

  # example.json Finish in 0.19
  # small.json   Finish in 7.76
  # medium.json  Finish in 61.35
  # large.json   Finish in 616.38
  test 'reload small.json is fast' do
    time = Benchmark.realtime do
      ReloadJsonUtil.new('fixtures/small.json').run
    end

    assert time < 2, 'Reload is too long'
  end
end
