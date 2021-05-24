class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])
    @trips = Trip.includes(:bus).where(from: @from, to: @to).order(:start_time)

    #@pagy, @trips = pagy(trips)
    #return render json: @trips.to_json
  end
end
