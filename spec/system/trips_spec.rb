require 'rails_helper'
require 'rake'
Rails.application.load_tasks

describe 'view schedule', type: :feature do
  before do
    Rake::Task['reload_json'].invoke('fixtures/example.json')
  end

  let(:text_trip_1) {
    [
      'Отправление: 17:30',
      'Прибытие: 18:07',
      'В пути: 0ч. 37мин.',
      'Цена: 1р. 73коп.',
      'Автобус: Икарус №123',
      'Сервисы в автобусе:',
      'Туалет',
      'WiFi',
    ]
  }

  let(:text_trip_2) {
    [
      'Отправление: 18:30',
      'Прибытие: 23:45',
      'В пути: 5ч. 15мин.',
      'Цена: 9р. 69коп.',
      'Автобус: Икарус №123',
      'Сервисы в автобусе:',
      'Туалет',
      'WiFi',
    ]
  }

  let(:text_trip_3) {
    [
      'Отправление: 19:30',
      'Прибытие: 19:51',
      'В пути: 0ч. 21мин.',
      'Цена: 6р. 63коп.',
      'Автобус: Икарус №123',
      'Сервисы в автобусе:',
      'Туалет',
      'WiFi',
    ]
  }

  let(:text_trip_4) {
    [
      'Отправление: 20:30',
      'Прибытие: 01:22',
      'В пути: 4ч. 52мин.',
      'Цена: 0р. 22коп.',
      'Автобус: Икарус №123',
      'Сервисы в автобусе:',
      'Туалет',
      'WiFi',
    ]
  }

  let(:text_trip_5) {
    [
      'Отправление: 21:30',
      'Прибытие: 00:33',
      'В пути: 3ч. 3мин.',
      'Цена: 8р. 46коп.',
      'Автобус: Икарус №123',
      'Сервисы в автобусе:',
      'Туалет',
      'WiFi',
    ]
  }

  it 'shows schedule for Moscow - Samara' do
    visit URI.escape('/автобусы/Самара/Москва')

    expect(page).to have_content('В расписании 5 рейсов')
    expect(all('li').count).to eq(40)

    text_trip_1.each { |text| expect(all('ul')[0]).to have_content(text) }
    text_trip_2.each { |text| expect(all('ul')[2]).to have_content(text) }
    text_trip_3.each { |text| expect(all('ul')[4]).to have_content(text) }
    text_trip_4.each { |text| expect(all('ul')[6]).to have_content(text) }
    text_trip_5.each { |text| expect(all('ul')[8]).to have_content(text) }
  end
end
