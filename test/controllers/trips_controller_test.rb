# frozen_string_literal: true

require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Task4::Application.load_tasks
    Rake::Task['reload_json'].invoke('fixtures/example.json')
  end

  test "should get index" do
    get URI.escape('/автобусы/Самара/Москва')
    assert_equal strip(fixture('trips_example.html')), strip(@response.body)
    assert_response :success
  end
end
