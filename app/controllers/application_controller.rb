class ApplicationController < ActionController::Base
  before_action :check_rack_mini_profiler

  def check_rack_mini_profiler
    Rack::MiniProfiler.authorize_request
    Rack::MiniProfiler.config.authorization_mode = :whitelist
  end
end
