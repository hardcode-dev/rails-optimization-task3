# spec/system/trips_spec.rb
require 'rails_helper'

RSpec.describe "Trips Page", type: :system do
  before do
  end

  let!(:from_city) { City.create!(name: "Москва") }
  let!(:to_city)   { City.create!(name: "Санкт-Петербург") }
  let!(:bus)       { Bus.create!(number: "A123AA", model: "Икарус") }
  
  let!(:trip) do
    Trip.create!(
      from: from_city,
      to:   to_city,
      bus:  bus,
      start_time: "10:00",
      duration_minutes: 300,
      price_cents: 150_00
    )
  end

  it "отображает index и нужные элементы" do
    visit "/автобусы/#{from_city.name}/#{to_city.name}"

    expect(page).to have_selector("h1", text: "Автобусы Москва – Санкт-Петербург")
    expect(page).to have_selector("h2", text: "В расписании 1 рейс")
    expect(page).to have_selector("li", text: "Отправление: 10:00") 
    expect(page).to have_selector("li", text: "Прибытие: 15:00")
    
    expect(page).to have_selector("li", text: "Цена: 150р. 0коп.")
    expect(page).to have_text("====================================================")
  end
end
