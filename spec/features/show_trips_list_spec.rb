require 'rails_helper'
feature 'Просмотр списка маршрутов' do
  given(:bus) { FactoryBot.create(:bus) }
  given(:from_city) { FactoryBot.create(:city) }
  given(:to_city) { FactoryBot.create(:city) }
  given!(:trips) { FactoryBot.create_list(:trip, 3, from_id: from_city.id, to_id: to_city.id, bus_id: bus.id) }

  scenario 'Пользователь открывает список маршрутов' do
    visit "#{URI.encode('автобусы')}/#{from_city.name}/#{to_city.name}"

    expect(page).to have_content from_city.name
    expect(page).to have_content from_city.name
    expect(page).to have_content "В расписании #{trips.size} рейсов"

    trips.each do |trip|
      expect(page).to have_content "Отправление: #{trip.start_time}"
      expect(page).to have_content "Прибытие: #{(Time.parse(trip.start_time) + trip.duration_minutes.minutes).strftime('%H:%M')}"
      expect(page).to have_content "В пути: #{trip.duration_minutes / 60}ч. #{trip.duration_minutes % 60}мин."
      expect(page).to have_content "Цена: #{trip.price_cents / 100}р. #{trip.price_cents % 100}коп."
      expect(page).to have_content "Автобус: #{trip.bus.model} №#{trip.bus.number}"
    end
  end
end
