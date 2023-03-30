require 'test_helper'
require 'my_app/import'

class TestMe < Minitest::Test
  def test_result
    MyApp::Import.new(Rails.root.join("fixtures", 'example.json')).call
    assert_equal 10, Trip.count
    assert_equal 2, Bus.count
    assert_equal 3, Service.count
    assert_equal 2, City.count
    gaz = Bus.find_by!(number: '584', model: 'ГАЗ')
    icarus = Bus.find_by!(number: '123', model: 'Икарус')
    assert_equal ['Кондиционер общий', 'WiFi'], gaz.services.map(&:name)
    assert_equal ['Туалет', 'WiFi'], icarus.services.map(&:name)
    assert_equal 1, gaz.trips.size
    gaz_trip = gaz.trips.first
    gaz_trip_attributes = gaz_trip.attributes
    assert_equal(
      {
        'duration_minutes' => 315,
        'price_cents' => 969,
        'start_time' => '18:30',
      },
      gaz_trip_attributes.slice('duration_minutes', 'price_cents', 'start_time')
    )
    assert_equal 'Самара', gaz_trip.from.name
    assert_equal 'Москва', gaz_trip.to.name
  end
end