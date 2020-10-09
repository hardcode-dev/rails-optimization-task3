require 'rails_helper'

RSpec.describe 'trips/index.html.erb', type: :view  do
  it 'displays trips for direction' do

    from = City.find_by_name('Москва')
    to = City.find_by_name('Самара')

    assign :from, from
    assign :to, to
    assign :trips, Trip.eager_load(bus: [:services]).where(from: from, to: to).order(:start_time)

    render
    trips_txt = "<h1>\n  Автобусы Москва – Самара\n</h1>\n<h2>\n  В расписании 5 рейсов\n</h2>\n\n  <ul>\n    <li>Отправление: 11:00</li>\n<li>Прибытие: 13:48</li>\n<li>В пути: 2ч. 48мин.</li>\n<li>Цена: 4р. 74коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 12:00</li>\n<li>Прибытие: 17:23</li>\n<li>В пути: 5ч. 23мин.</li>\n<li>Цена: 6р. 72коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 13:00</li>\n<li>Прибытие: 18:04</li>\n<li>В пути: 5ч. 4мин.</li>\n<li>Цена: 6р. 41коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 14:00</li>\n<li>Прибытие: 23:58</li>\n<li>В пути: 9ч. 58мин.</li>\n<li>Цена: 6р. 29коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 15:00</li>\n<li>Прибытие: 17:07</li>\n<li>В пути: 2ч. 7мин.</li>\n<li>Цена: 7р. 95коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n"
    expect(rendered).to eq trips_txt
  end
end