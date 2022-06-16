# frozen_string_literal: true

require "rails_helper"
require 'nokogiri'
require 'compare-xml'


RSpec::Matchers.define :match_html do |expected_html, **options|
  match do |actual_html|
    expected_doc = Nokogiri::HTML.fragment(expected_html)
    actual_doc = Nokogiri::HTML.fragment(actual_html)

    # Options documented here: https://github.com/vkononov/compare-xml
    default_options = {
      collapse_whitespace: true,
      ignore_attr_order: true,
      ignore_comments: true
    }

    options = default_options.merge(options).merge(verbose: true)

    diff = CompareXML.equivalent?(expected_doc, actual_doc, **options)
    diff.blank?
  end

end

RSpec.describe "Trips", type: :request do
  before do
    JsonImporter.new.call(file_name: "fixtures/example.json")
  end

  describe "GET /trips" do
    it "renders buses list" do
      get trips_path("Самара", "Москва")
      expect(response).to have_http_status(200)
      expect(response.body).to match_html(<<~HTML, ignore_text_nodes: true)
      <!DOCTYPE html>
        <html>
          <head>
            <title>Task4</title>
            <link rel="stylesheet" media="all" href="/assets/application-f0d704deea029cf000697e2c0181ec173a1b474645466ed843eb5ee7bb215794.css" />
            <script src="/assets/application-5480cd6ff3f625da5fbc65a5bacbdb0ec40f8ba6fcea845163a544913a5dd0d0.js"></script>
          </head>
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
        </html>
      HTML
    end
  end
end
