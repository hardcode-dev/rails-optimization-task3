class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])
    #@trips = Trip.where(from: @from, to: @to).order(:start_time) - # 8752 ms
    #@trips = Trip.eager_load(:bus).where(from: @from, to: @to).order(:start_time) # 3752 ms
    @trips = Trip.preload(:bus).where(from: @from, to: @to).order(:start_time) # 3342 ms
  end
end
