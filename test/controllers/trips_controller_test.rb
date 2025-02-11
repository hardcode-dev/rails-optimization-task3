require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    from = cities(:moskow)
    to = cities(:volgograd)

    get "/buses/#{from.name}/#{to.name}"

    assert_response :success
  end 
end