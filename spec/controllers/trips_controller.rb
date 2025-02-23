# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  subject(:get_index) { get :index, params: { from: from_city.name, to: to_city.name } }

  let(:from_city) { City.create!(name: "Москва") }
  let(:to_city) { City.create!(name: "Санкт-Петербург") }
  let(:bus) { Bus.create!(number: "A123AA", model: "Икарус") }

  let(:trip) do
    Trip.create!(
      from: from_city,
      to: to_city,
      bus: bus,
      start_time: "10:00",
      duration_minutes: 300,
      price_cents: 150_00
    )
  end

  it "should get index" do
    get_index
    expect(response).to be_successful
  end
end
