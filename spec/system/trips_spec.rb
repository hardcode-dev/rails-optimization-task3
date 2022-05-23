require 'json_loader'
require 'rails_helper'

RSpec.describe 'Trips', type: :system do
  before(:all) do
    JsonLoader.new.perform('fixtures/example.json')
  end

  before do
    visit trips_url(from: "Самара", to: "Москва")
  end

  it 'displays trips' do
    expect(page).to have_text('В расписании 5 рейсов')

    page_html = page.html.squish

    trip_html = <<~HTML
      <ul>
        <li>Отправление: 17:30</li>
        <li>Прибытие: 18:07</li>
        <li>В пути: 0ч. 37мин.</li>
        <li>Цена: 1р. 73коп.</li>
        <li>Автобус: Икарус №123</li>
        <li>Сервисы в автобусе:</li>
        <ul>
          <li>Туалет</li>
          <li>WiFi</li>
        </ul>
      </ul>
    HTML
    expect(page_html).to include(trip_html.squish)

    trip_html = <<~HTML
      <ul>
        <li>Отправление: 18:30</li>
        <li>Прибытие: 23:45</li>
        <li>В пути: 5ч. 15мин.</li>
        <li>Цена: 9р. 69коп.</li>
        <li>Автобус: Икарус №123</li>
        <li>Сервисы в автобусе:</li>
        <ul>
          <li>Туалет</li>
          <li>WiFi</li>
        </ul>
      </ul>
    HTML
    expect(page_html).to include(trip_html.squish)

    trip_html = <<~HTML
      <ul>
        <li>Отправление: 19:30</li>
        <li>Прибытие: 19:51</li>
        <li>В пути: 0ч. 21мин.</li>
        <li>Цена: 6р. 63коп.</li>
        <li>Автобус: Икарус №123</li>
        <li>Сервисы в автобусе:</li>
        <ul>
          <li>Туалет</li>
          <li>WiFi</li>
        </ul>
      </ul>
    HTML
    expect(page_html).to include(trip_html.squish)

    trip_html = <<~HTML
      <ul>
        <li>Отправление: 20:30</li>
        <li>Прибытие: 01:22</li>
        <li>В пути: 4ч. 52мин.</li>
        <li>Цена: 0р. 22коп.</li>
        <li>Автобус: Икарус №123</li>
        <li>Сервисы в автобусе:</li>
        <ul>
          <li>Туалет</li>
          <li>WiFi</li>
        </ul>
      </ul>
    HTML
    expect(page_html).to include(trip_html.squish)

    trip_html = <<~HTML
      <ul>
        <li>Отправление: 21:30</li>
        <li>Прибытие: 00:33</li>
        <li>В пути: 3ч. 3мин.</li>
        <li>Цена: 8р. 46коп.</li>
        <li>Автобус: Икарус №123</li>
        <li>Сервисы в автобусе:</li>
        <ul>
          <li>Туалет</li>
          <li>WiFi</li>
        </ul>
      </ul>
    HTML
    expect(page_html).to include(trip_html.squish)
  end
end
