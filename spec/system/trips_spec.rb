require 'rails_helper'

describe 'Feature spec for trips representations', type: :feature do
  subject { visit URI.encode(path) }

  let(:path) { '/автобусы/Рыбинск/Сочи' }

  before do
    City.create!(name: 'Рыбинск')
    City.create!(name: 'Сочи')
    Service.create!(name: 'Ремни безопасности')
    Service.create!(name: 'Телевизор индивидуальный')
    Service.create!(name: 'Кондиционер общий')
    Service.create!(name: 'Работающий туалет')
    Bus.create!(number: '739', model: 'УАЗ', services: Service.all)
    Bus.create!(number: '880', model: 'Икарус', services: [Service.last])
    Trip.create!(
      from: City.first, to: City.last, start_time: '15:13', duration_minutes: 271, price_cents: 6803, bus: Bus.last
    )
    Trip.create!(
      from: City.first, to: City.last, start_time: '12:13', duration_minutes: 150, price_cents: 100, bus: Bus.first
    )
  end

  it 'represents trips correctly', :aggregate_failures do
    subject

    # header of page
    expect(page).to have_content 'Автобусы Рыбинск – Сочи'
    expect(page).to have_content 'В расписании 2 рейсов'
    # first trip
    expect(page).to have_content 'Отправление: 12:13'
    expect(page).to have_content 'Прибытие: 14:43'
    expect(page).to have_content 'В пути: 2ч. 30мин.'
    expect(page).to have_content 'Цена: 1р. 0коп.'
    expect(page).to have_content 'Автобус: Икарус №880'
    expect(page).to have_content 'Сервисы в автобусе:'
    expect(page).to have_content 'Ремни безопасности'
    expect(page).to have_content 'Телевизор индивидуальный'
    expect(page).to have_content 'Кондиционер общий'
    # second trip
    expect(page).to have_content 'Отправление: 15:13'
    expect(page).to have_content 'Прибытие: 19:44'
    expect(page).to have_content 'В пути: 4ч. 31мин.'
    expect(page).to have_content 'Цена: 68р. 3коп.'
    expect(page).to have_content 'Автобус: УАЗ №739'
    expect(page).to have_content 'Работающий туалет'
  end
end