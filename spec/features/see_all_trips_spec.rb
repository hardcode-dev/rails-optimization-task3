# frozen_string_literal: true

require 'rails_helper'

feature "User can see all trips on 'автобусы/Самара/Москва' page", "
  In order to track trips for further purchasing
  As a User
  I'd like to be able to track trips on 'автобусы/Самара/Москва' page
" do
  # Load data from fixture
  before do
    rake = Rake::Application.new
    task_name = 'reload_json'
    task_path = 'lib/tasks/reload_json'
    loaded_files_excluding_current_rake_file =
      $LOADED_FEATURES.reject { |file| file == Rails.root.join("#{task_path}.rake").to_s }
    Rake.application = rake
    Rake.application.rake_require(task_path, [Rails.root.to_s],
                                  loaded_files_excluding_current_rake_file)
    Rake::Task.define_task(:environment)
    rake[task_name].invoke('spec/fixtures/example.json')
  end

  scenario 'User see all existing trips' do
    visit '/%D0%B0%D0%B2%D1%82%D0%BE%D0%B1%D1%83%D1%81%D1%8B/' \
          '%D0%A1%D0%B0%D0%BC%D0%B0%D1%80%D0%B0/%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0/'
    page_city = City.find_by(name: 'Самара')
    trips_on_page = Trip.where(from: page_city).includes(:bus)

    trips_on_page.each do |trip|
      expect(page).to have_content trip.start_time
      expect(page).to have_content((Time.parse(trip.start_time) + trip.duration_minutes.minutes)
        .strftime('%H:%M'))
      expect(page).to have_content("#{trip.price_cents / 100}р. #{trip.price_cents % 100}коп.")
      expect(page).to have_content trip.bus.number
      expect(page).to have_content trip.bus.model
      trip.bus.services.each do |service|
        expect(page).to have_content service.name
      end
    end
  end
end
