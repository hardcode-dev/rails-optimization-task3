class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])
    @trips = Trip.where(from: @from, to: @to).includes(bus: :services).order(:start_time)
  end
end
