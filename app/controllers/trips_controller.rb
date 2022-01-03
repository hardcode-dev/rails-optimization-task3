class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])
    @trips = Trip.eager_load(bus: :services).where(from_id: @from.id, to_id: @to.id).order('trips.start_time')
  end
end
