# frozen_string_literal: true

require 'rails_helper'
Rails.application.load_tasks
RSpec.describe TripsController, type: :controller do
  RSpec.configure do |config|
    config.render_views
  end

  before do
    Rake::Task['reload_json'].invoke('fixtures/example.json')
  end

  subject { get :index, params: { from: 'Самара', to: 'Москва' } }

it "return correct html page" do
  subject
  expect(response.body).to match file_fixture("trips_example.html").read
end
  end