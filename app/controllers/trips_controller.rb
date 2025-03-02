class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])
    @trips = Trip.preload(:from, :to, bus: :services).where(from: @from, to: @to)
  end
end
