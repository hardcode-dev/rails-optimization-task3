# frozen_string_literal: true

require 'test_helper'
require 'rake'

class TripsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Task4::Application.load_tasks
    file_name = 'fixtures/example.json'
    Rake::Task['reload_json'].invoke(file_name)
  end

  test 'should get index' do
    get URI.parse(URI.escape('/автобусы/Самара/Москва'))

    assert_response :success
    assert_select('h1', 'Автобусы Самара – Москва')
    assert_select('h2', 'В расписании 5 рейсов')
  end
end
