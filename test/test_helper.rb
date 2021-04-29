ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def fixture(name)
    File.read(Rails.root.join('test', 'fixtures', 'files', name))
  end

  def strip(text)
    @_sanitizer ||= Rails::Html::FullSanitizer.new
    @_sanitizer.sanitize(text)
  end
end
