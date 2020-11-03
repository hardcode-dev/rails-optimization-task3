# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TripsController, type: :request do
  subject(:request) { get url }

  let(:file) { 'fixtures/example.json' }

  let(:url) { URI.encode('/автобусы/Москва/Самара').to_s }

  describe 'correctness' do
    before { ReimportDatabaseService.new(file_name: file).call }

    it 'renders correct page' do
      request

      expect(response.body).to eq(required_response)
    end
  end

  describe 'Performance' do
    before { ReimportDatabaseService.new(file_name: file).call }

    let(:file) { 'fixtures/example.json' }

    it 'renders correct page' do
      expect { request }.to perform_under(60).sec
    end
  end

  private

  def required_response
    "<!DOCTYPE html>\n" \
      "<html>\n" \
      "  <head>\n" \
      "    <title>Task4</title>\n" \
      "    \n" \
      "    \n" \
      "\n" \
      "    <link rel=\"stylesheet\" media=\"all\" href=\"/assets/application-b324c44f04a0d0da658824105489a2676d49df561c3d06723770321fd441977c.css\" />\n" \
      "    <script src=\"/assets/application-85d9a73fda0f0681d4ef3a9b1147090e2e807aa98db37994df53a3e31b5538c9.js\"></script>\n" \
      "  </head>\n" \
      "\n" \
      "  <body>\n" \
      "    <h1>\n" \
      "  Автобусы Москва – Самара\n" \
      "</h1>\n" \
      "<h2>\n" \
      "  В расписании 5 рейсов\n" \
      "</h2>\n" \
      "\n" \
      "  <ul>\n" \
      "    <li>Отправление: 11:00</li>\n" \
      "<li>Прибытие: 13:48</li>\n" \
      "<li>В пути: 2ч. 48мин.</li>\n" \
      "<li>Цена: 4р. 74коп.</li>\n" \
      "<li>Автобус: Икарус №123</li>\n" \
      "\n" \
      "      <li>Сервисы в автобусе:</li>\n" \
      "<ul>\n" \
      "    <li>Туалет</li>\n" \
      "\n" \
      "    <li>WiFi</li>\n" \
      "\n" \
      "</ul>\n" \
      "\n" \
      "  </ul>\n" \
      "  ====================================================\n" \
      "\n" \
      "  <ul>\n" \
      "    <li>Отправление: 12:00</li>\n" \
      "<li>Прибытие: 17:23</li>\n" \
      "<li>В пути: 5ч. 23мин.</li>\n" \
      "<li>Цена: 6р. 72коп.</li>\n" \
      "<li>Автобус: Икарус №123</li>\n" \
      "\n" \
      "      <li>Сервисы в автобусе:</li>\n" \
      "<ul>\n" \
      "    <li>Туалет</li>\n" \
      "\n" \
      "    <li>WiFi</li>\n" \
      "\n" \
      "</ul>\n" \
      "\n" \
      "  </ul>\n" \
      "  ====================================================\n" \
      "\n" \
      "  <ul>\n" \
      "    <li>Отправление: 13:00</li>\n" \
      "<li>Прибытие: 18:04</li>\n" \
      "<li>В пути: 5ч. 4мин.</li>\n" \
      "<li>Цена: 6р. 41коп.</li>\n" \
      "<li>Автобус: Икарус №123</li>\n" \
      "\n" \
      "      <li>Сервисы в автобусе:</li>\n" \
      "<ul>\n" \
      "    <li>Туалет</li>\n" \
      "\n" \
      "    <li>WiFi</li>\n" \
      "\n" \
      "</ul>\n" \
      "\n" \
      "  </ul>\n" \
      "  ====================================================\n" \
      "\n" \
      "  <ul>\n" \
      "    <li>Отправление: 14:00</li>\n" \
      "<li>Прибытие: 23:58</li>\n" \
      "<li>В пути: 9ч. 58мин.</li>\n" \
      "<li>Цена: 6р. 29коп.</li>\n" \
      "<li>Автобус: Икарус №123</li>\n" \
      "\n" \
      "      <li>Сервисы в автобусе:</li>\n" \
      "<ul>\n" \
      "    <li>Туалет</li>\n" \
      "\n" \
      "    <li>WiFi</li>\n" \
      "\n" \
      "</ul>\n" \
      "\n" \
      "  </ul>\n" \
      "  ====================================================\n" \
      "\n" \
      "  <ul>\n" \
      "    <li>Отправление: 15:00</li>\n" \
      "<li>Прибытие: 17:07</li>\n" \
      "<li>В пути: 2ч. 7мин.</li>\n" \
      "<li>Цена: 7р. 95коп.</li>\n" \
      "<li>Автобус: Икарус №123</li>\n" \
      "\n" \
      "      <li>Сервисы в автобусе:</li>\n" \
      "<ul>\n" \
      "    <li>Туалет</li>\n" \
      "\n" \
      "    <li>WiFi</li>\n" \
      "\n" \
      "</ul>\n" \
      "\n" \
      "  </ul>\n" \
      "  ====================================================\n" \
      "\n" \
      "\n" \
      "  </body>\n" \
      "</html>\n"
    "<!DOCTYPE html>\n<html>\n  <head>\n    <title>Task4</title>\n    \n    \n\n    <link rel=\"stylesheet\" media=\"all\" href=\"/assets/application-b324c44f04a0d0da658824105489a2676d49df561c3d06723770321fd441977c.css\" />\n    <script src=\"/assets/application-85d9a73fda0f0681d4ef3a9b1147090e2e807aa98db37994df53a3e31b5538c9.js\"></script>\n  </head>\n\n  <body>\n    <h1>\n  Автобусы Москва – Самара\n</h1>\n<h2>\n  В расписании 5 рейсов\n</h2>\n\n  <ul>\n    <li>Отправление: 11:00</li>\n<li>Прибытие: 13:48</li>\n<li>В пути: 2ч. 48мин.</li>\n<li>Цена: 4р. 74коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 12:00</li>\n<li>Прибытие: 17:23</li>\n<li>В пути: 5ч. 23мин.</li>\n<li>Цена: 6р. 72коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 13:00</li>\n<li>Прибытие: 18:04</li>\n<li>В пути: 5ч. 4мин.</li>\n<li>Цена: 6р. 41коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 14:00</li>\n<li>Прибытие: 23:58</li>\n<li>В пути: 9ч. 58мин.</li>\n<li>Цена: 6р. 29коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 15:00</li>\n<li>Прибытие: 17:07</li>\n<li>В пути: 2ч. 7мин.</li>\n<li>Цена: 7р. 95коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n\n  </body>\n</html>\n"
  end
end
