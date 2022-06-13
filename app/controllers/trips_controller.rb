class TripsController < ApplicationController
  def index
    from = City.find_by_name!(params[:from])
    to = City.find_by_name!(params[:to])
    @from_name = from.name
    @to_name = to.name
    @trips = Trip.where(from: from, to: to).order(:start_time).includes(bus: :services)
  end
end
