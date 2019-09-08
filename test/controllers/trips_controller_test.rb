require_relative '../test_helper'
# require 'populate_database'
# require 'benchmark'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  BODY = "<h1>\n  Автобусы Самара – Москва\n</h1>\n<h2>\n  В расписании 5 рейсов\n</h2>\n\n  <ul>\n    <li>Отправление: 17:30</li>\n<li>Прибытие: 18:07</li>\n<li>В пути: 0ч. 37мин.</li>\n<li>Цена: 1р. 73коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 18:30</li>\n<li>Прибытие: 23:45</li>\n<li>В пути: 5ч. 15мин.</li>\n<li>Цена: 9р. 69коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 19:30</li>\n<li>Прибытие: 19:51</li>\n<li>В пути: 0ч. 21мин.</li>\n<li>Цена: 6р. 63коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 20:30</li>\n<li>Прибытие: 01:22</li>\n<li>В пути: 4ч. 52мин.</li>\n<li>Цена: 0р. 22коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 21:30</li>\n<li>Прибытие: 00:33</li>\n<li>В пути: 3ч. 3мин.</li>\n<li>Цена: 8р. 46коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n\n  </body>\n"

  test 'Should return correct html' do
    JsonFileToDbProcessor.new('fixtures/example.json').call
    get URI.encode('/автобусы/Самара/Москва')

    assert_response :success
    assert @response.body.include? BODY
  end
end