class TripsController < ApplicationController
  def index
    @from = City.find_by(name: params[:from])
    @to = City.find_by(name: params[:to])
    @trips = Trip.includes(bus: [:services]).where(from: @from, to: @to).order(:start_time)
  end
end
