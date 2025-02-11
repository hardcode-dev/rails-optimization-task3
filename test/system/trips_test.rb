# frozen_string_literal: true

require 'application_system_test_case'

class TripsTest < ApplicationSystemTestCase
  test 'visit index page' do
    from = cities(:moskow)
    to = cities(:volgograd)

    visit "/buses/#{from.name}/#{to.name}"

    page.assert_selector('h1', text: "Автобусы #{from.name} – #{to.name}")
    page.assert_selector('h2', text: "В расписании 1 рейс")
    page.assert_selector('li', text: "Отправление: 12:00")
    page.assert_selector('li', text: "Прибытие: 12:00")
    page.assert_selector('li', text: "В пути: 0ч. 0мин.")
    page.assert_selector('li', text: "Цена: 0р. 0коп.")
    page.assert_selector('li', text: "Сервисы в автобусе:")
    page.assert_selector('li', text: "Кондиционер общий")
  end
end