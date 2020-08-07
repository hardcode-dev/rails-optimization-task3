require 'test_helper'

class TripsIndexTest < ActionDispatch::IntegrationTest
  test "Index for 100 trips in 0.3 second" do
    TripsLoad.perform('fixtures/medium.json')
    total = Benchmark.measure{ get URI.escape('/автобусы/Самара/Москва') }.total
    assert(total < 0.3)
  end
end
