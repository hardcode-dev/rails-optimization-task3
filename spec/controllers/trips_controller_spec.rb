# frozen_string_literal: true

require "rails_helper"

Rails.application.load_tasks

RSpec.describe TripsController, type: :controller do
  describe "#index" do
    # решил не заморачиваться в выносе в сервисы или заводом факторибота
    subject { Rake::Task['reload_json'].invoke(file_name) }
    let(:file_name) { 'fixtures/example.json' }
    let(:expected_response) { "<!DOCTYPE html>\n<html>\n  <head>\n    <title>Task4</title>\n    \n    \n\n    <link rel=\"stylesheet\" media=\"all\" href=\"/assets/application-b324c44f04a0d0da658824105489a2676d49df561c3d06723770321fd441977c.css\" />\n    <script src=\"/assets/application-61274cb83e605b2041524261e46fe317d7db524e1ce4d0fd046034a7a3bbdf23.js\"></script>\n  </head>\n\n  <body>\n    <h1>\n  Автобусы Москва – Самара\n</h1>\n<h2>\n  В расписании 5 рейсов\n</h2>\n\n  <ul>\n    <li>Отправление: 11:00</li>\n    <li>Прибытие: 13:48</li>\n    <li>В пути: 2ч. 48мин.</li>\n    <li>Цена: 4р. 74коп.</li>\n    <li>Автобус: Икарус №123</li>\n\n    <li>Сервисы в автобусе:</li>\n      <li>Туалет</li>\n<li>WiFi</li>\n\n  </ul>\n  <ul>\n    <li>Отправление: 12:00</li>\n    <li>Прибытие: 17:23</li>\n    <li>В пути: 5ч. 23мин.</li>\n    <li>Цена: 6р. 72коп.</li>\n    <li>Автобус: Икарус №123</li>\n\n    <li>Сервисы в автобусе:</li>\n      <li>Туалет</li>\n<li>WiFi</li>\n\n  </ul>\n  <ul>\n    <li>Отправление: 13:00</li>\n    <li>Прибытие: 18:04</li>\n    <li>В пути: 5ч. 4мин.</li>\n    <li>Цена: 6р. 41коп.</li>\n    <li>Автобус: Икарус №123</li>\n\n    <li>Сервисы в автобусе:</li>\n      <li>Туалет</li>\n<li>WiFi</li>\n\n  </ul>\n  <ul>\n    <li>Отправление: 14:00</li>\n    <li>Прибытие: 23:58</li>\n    <li>В пути: 9ч. 58мин.</li>\n    <li>Цена: 6р. 29коп.</li>\n    <li>Автобус: Икарус №123</li>\n\n    <li>Сервисы в автобусе:</li>\n      <li>Туалет</li>\n<li>WiFi</li>\n\n  </ul>\n  <ul>\n    <li>Отправление: 15:00</li>\n    <li>Прибытие: 17:07</li>\n    <li>В пути: 2ч. 7мин.</li>\n    <li>Цена: 7р. 95коп.</li>\n    <li>Автобус: Икарус №123</li>\n\n    <li>Сервисы в автобусе:</li>\n      <li>Туалет</li>\n<li>WiFi</li>\n\n  </ul>\n\n&lt;nav class=&quot;pagy-nav pagination&quot; role=&quot;navigation&quot; aria-label=&quot;pager&quot;&gt;&lt;span class=&quot;page prev disabled&quot;&gt;&amp;lsaquo;&amp;nbsp;Prev&lt;/span&gt; &lt;span class=&quot;page active&quot;&gt;1&lt;/span&gt; &lt;span class=&quot;page next disabled&quot;&gt;Next&amp;nbsp;&amp;rsaquo;&lt;/span&gt;&lt;/nav&gt;\n\n  </body>\n</html>\n" }

    before do
      subject
      get :index, params: { from: "Москва", to: "Самара"}
    end

    it "returns correct trips" do
      expect(response.body).to eq(expected_response)
    end
  end
end
