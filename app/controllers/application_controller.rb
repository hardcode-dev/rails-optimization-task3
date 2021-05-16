class ApplicationController < ActionController::Base
  include Pagy::Backend

  unless Rails.env.production?
    before_action do
      Prosopite.scan
    end

    after_action do
      Prosopite.finish
    end
  end
end
