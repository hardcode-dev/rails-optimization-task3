require 'test_helper'

class BusScheduleTest < ActionDispatch::IntegrationTest
  def setup
    `rake reload_json[fixtures/example.json]`
  end

  test "retrieve and check bus schedule page" do
    get URI.encode('/автобусы/Самара/Москва')
    assert_response :success

    assert_includes @response.body, 'Автобусы Самара – Москва'
    assert_includes @response.body, 'В расписании 5 рейсов'

    schedule = [
      { departure: '17:30', arrival: '18:07', duration: '0ч. 37мин.', price: '1р. 73коп.', bus: 'Икарус №123', services: ['Туалет', 'WiFi'] },
      { departure: '18:30', arrival: '23:45', duration: '5ч. 15мин.', price: '9р. 69коп.', bus: 'Икарус №123', services: ['Туалет', 'WiFi'] },
      { departure: '19:30', arrival: '19:51', duration: '0ч. 21мин.', price: '6р. 63коп.', bus: 'Икарус №123', services: ['Туалет', 'WiFi'] },
      { departure: '20:30', arrival: '01:22', duration: '4ч. 52мин.', price: '0р. 22коп.', bus: 'Икарус №123', services: ['Туалет', 'WiFi'] },
      { departure: '21:30', arrival: '00:33', duration: '3ч. 3мин.', price: '8р. 46коп.', bus: 'Икарус №123', services: ['Туалет', 'WiFi'] }
    ]

    schedule.each do |entry|
      assert_includes @response.body, "Отправление: #{entry[:departure]}"
      assert_includes @response.body, "Прибытие: #{entry[:arrival]}"
      assert_includes @response.body, "В пути: #{entry[:duration]}"
      assert_includes @response.body, "Цена: #{entry[:price]}"
      assert_includes @response.body, "Автобус: #{entry[:bus]}"
      entry[:services].each do |service|
        assert_includes @response.body, service
      end
      assert_includes @response.body, "===================="
    end
  end
end