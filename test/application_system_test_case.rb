# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400] do |driver|
    driver.add_argument('--no-sandbox')
    driver.add_argument('--disable-gpu')
  end
end