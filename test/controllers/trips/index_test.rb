# frozen_string_literal: true

require_relative '../../test_helper'

class TripsController::IndexTest < ActionController::TestCase
  def setup
     ::UtilsService.call('fixtures/example.json')
  end

  def test_html
    get(:index, params: {from: 'Самара', to: 'Москва'})

    assert_response(:success)
    assert_equal(@response.body, File.read('test/fixtures/files/example_index.html'))
  end
end
