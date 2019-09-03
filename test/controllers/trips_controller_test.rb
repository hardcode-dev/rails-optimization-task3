require_relative '../test_helper'
require 'populate_database'
require 'benchmark'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  VALID_BODY = "<!DOCTYPE html>\n<html>\n  <head>\n    <title>Task4</title>\n    \n    \n\n    <link rel=\"stylesheet\" media=\"all\" href=\"/assets/application-f0d704deea029cf000697e2c0181ec173a1b474645466ed843eb5ee7bb215794.css\" />\n    <script src=\"/assets/application-5480cd6ff3f625da5fbc65a5bacbdb0ec40f8ba6fcea845163a544913a5dd0d0.js\"></script>\n  </head>\n\n  <body>\n    <h1>\n  Автобусы Самара – Москва\n</h1>\n<h2>\n  В расписании 5 рейсов\n</h2>\n\n  <ul>\n    <li>Отправление: 17:30</li>\n    <li>Прибытие: 18:07</li>\n    <li>В пути: 0ч. 37мин.</li>\n    <li>Цена: 1р. 73коп.</li>\n    <li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n      <ul>\n        <li>Туалет</li>\n        <li>WiFi</li>\n      </ul>\n  </ul>\n  ====================================================\n  <ul>\n    <li>Отправление: 18:30</li>\n    <li>Прибытие: 23:45</li>\n    <li>В пути: 5ч. 15мин.</li>\n    <li>Цена: 9р. 69коп.</li>\n    <li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n      <ul>\n        <li>Туалет</li>\n        <li>WiFi</li>\n      </ul>\n  </ul>\n  ====================================================\n  <ul>\n    <li>Отправление: 19:30</li>\n    <li>Прибытие: 19:51</li>\n    <li>В пути: 0ч. 21мин.</li>\n    <li>Цена: 6р. 63коп.</li>\n    <li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n      <ul>\n        <li>Туалет</li>\n        <li>WiFi</li>\n      </ul>\n  </ul>\n  ====================================================\n  <ul>\n    <li>Отправление: 20:30</li>\n    <li>Прибытие: 01:22</li>\n    <li>В пути: 4ч. 52мин.</li>\n    <li>Цена: 0р. 22коп.</li>\n    <li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n      <ul>\n        <li>Туалет</li>\n        <li>WiFi</li>\n      </ul>\n  </ul>\n  ====================================================\n  <ul>\n    <li>Отправление: 21:30</li>\n    <li>Прибытие: 00:33</li>\n    <li>В пути: 3ч. 3мин.</li>\n    <li>Цена: 8р. 46коп.</li>\n    <li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n      <ul>\n        <li>Туалет</li>\n        <li>WiFi</li>\n      </ul>\n  </ul>\n  ====================================================\n\n  </body>\n</html>\n"

  test 'Should return correct html' do
    PopulateDatabase.call(file_path: 'fixtures/example.json')
    get URI.encode('/автобусы/Самара/Москва')

    assert_response :success
    assert_equal VALID_BODY, @response.body
  end

  def test_work_time
    PopulateDatabase.call(file_path: 'fixtures/small.json')

    time = Benchmark.realtime {
      get URI.encode('/автобусы/Самара/Москва')
    }
    assert_operator 0.5, :>, time.real
  end
end
