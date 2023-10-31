require 'rails_helper'

RSpec.describe 'displays trips' do
  let(:example_path) { 'fixtures/example.json' }
  let(:example_data) { JSON.parse File.read(example_path) }
  let(:good_trips) { example_data.select { |t| t['from'] == 'Самара' && t['to'] == 'Москва' } }
  let(:bad_trips) { bad_trips - good_trips }
  let(:link) { URI.encode('/автобусы/Самара/Москва') }

  before { `bin/rake reload_json[#{example_path}]` }

  it 'displays relevant trips with correct details' do
    visit link
    expect(page).to have_content("В расписании #{good_trips.count} рейсов")
    good_trips.each do |trip|
      expect(page).to have_content("Отправление: #{trip['start_time']}")
      expect(page).to have_content("Прибытие: #{(Time.parse(trip['start_time']) + trip['duration_minutes'].minutes).strftime('%H:%M')}")
      expect(page).to have_content("В пути: #{trip['duration_minutes'] / 60}ч. #{trip['duration_minutes'] % 60}мин.")
      expect(page).to have_content("Цена: #{trip['price_cents'] / 100}р. #{trip['price_cents'] % 100}коп.")
      expect(page).to have_content("Автобус: #{trip['bus']['model']} №#{trip['bus']['number']}")
    end
  end
end
