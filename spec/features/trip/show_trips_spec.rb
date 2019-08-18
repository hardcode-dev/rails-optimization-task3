require 'rails_helper'

feature ' Show trips and buses for selected cities' do
  let!(:trip) { create(:trip) }

  scenario 'get index page for selected cities' do
    visit show_trips_path(from: trip.from.name, to: trip.to.name)

    expect(page).to have_content trip.start_time
    expect(page).to have_content '20:07'
    expect(page).to have_content '1р. 0коп'
    expect(page).to have_content trip.to.name
    expect(page).to have_content trip.from.name
    expect(page).to have_content trip.bus.number
    expect(page).to have_content trip.bus.model
  end
end