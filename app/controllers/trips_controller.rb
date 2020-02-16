class TripsController < ApplicationController
  def index
    @from = params[:from]
    @to = params[:to]
    @trips = Trip.where(from: @from, to: @to).order(:start_time)
  end
end
