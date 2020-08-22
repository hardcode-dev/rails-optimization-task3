require 'test_helper'
require 'nokogiri'

class TripsControllerTest < ActionDispatch::IntegrationTest
  setup do

  end

  test 'regress test' do
    @data_file_path = Rails.root.join('fixtures', 'example.json')
    Seed::ReloadDataService.new(@data_file_path).call

    get 'http://127.0.0.1:3000/%D0%B0%D0%B2%D1%82%D0%BE%D0%B1%D1%83%D1%81%D1%8B/%D0%A1%D0%B0%D0%BC%D0%B0%D1%80%D0%B0/%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0'
    assert_response :success

    expected_text = "\n  \n    Task4\n    \n    \n\n    \n    \n  \n\n  \n    \n  Автобусы Самара – Москва\n\n\n  В расписании 5 рейсов\n\n\n  \n    Отправление: 17:30\nПрибытие: 18:07\nВ пути: 0ч. 37мин.\nЦена: 1р. 73коп.\nАвтобус: Икарус №123\n\n      Сервисы в автобусе:\n\n    WiFi\n\n    Туалет\n\n\n\n  \n  ====================================================\n\n  \n    Отправление: 18:30\nПрибытие: 23:45\nВ пути: 5ч. 15мин.\nЦена: 9р. 69коп.\nАвтобус: Икарус №123\n\n      Сервисы в автобусе:\n\n    WiFi\n\n    Туалет\n\n\n\n  \n  ====================================================\n\n  \n    Отправление: 19:30\nПрибытие: 19:51\nВ пути: 0ч. 21мин.\nЦена: 6р. 63коп.\nАвтобус: Икарус №123\n\n      Сервисы в автобусе:\n\n    WiFi\n\n    Туалет\n\n\n\n  \n  ====================================================\n\n  \n    Отправление: 20:30\nПрибытие: 01:22\nВ пути: 4ч. 52мин.\nЦена: 0р. 22коп.\nАвтобус: Икарус №123\n\n      Сервисы в автобусе:\n\n    WiFi\n\n    Туалет\n\n\n\n  \n  ====================================================\n\n  \n    Отправление: 21:30\nПрибытие: 00:33\nВ пути: 3ч. 3мин.\nЦена: 8р. 46коп.\nАвтобус: Икарус №123\n\n      Сервисы в автобусе:\n\n    WiFi\n\n    Туалет\n\n\n\n  \n  ====================================================\n\n\n  \n"
    expected_text.gsub!("\n", '')
    expected_text.gsub!("\\", '')
    expected_text.gsub!(' ', '')

    rendered_text = Nokogiri::HTML(@response.body).text
    rendered_text.gsub!("\n", '')
    rendered_text.gsub!("\\", '')
    rendered_text.gsub!(' ', '')

    assert_match expected_text, rendered_text
  end
end
