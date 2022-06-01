require 'rails_helper'
require 'nokogiri'

require_relative '../../lib/json_importer'

RSpec.describe 'Trips', type: :request do
  before(:all) { JSONImporter.new.call('fixtures/example.json') }
  after(:all) { [City, Bus, Service, Trip].each(&:delete_all) }

  describe 'GET /trips' do
    it 'renders buses list' do
      get trips_path('Самара', 'Москва')
      expect(response).to have_http_status(200)
      expect(sanitize(response.body.to_s)).to include(sanitize(proper_content))
    end
  end

  def sanitize(html)
    html.gsub(/\n/, '').gsub(/>\s+</, '><')
  end

  def proper_content
    <<~HTML
      <body>
          <h1>
        Автобусы Самара – Москва
      </h1>
      <h2>
        В расписании 5 рейсов
      </h2>

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
        ====================================================

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
        ====================================================

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
        ====================================================

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
        ====================================================

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
        ====================================================


        </body>
    HTML
  end
end
