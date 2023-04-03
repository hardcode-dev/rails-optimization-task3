class ApplicationController < ActionController::Base
  before_action :miniprofiler

  private

  def miniprofiler
    Rack::MiniProfiler.authorize_request # if user.admin?
  end
end
