class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])

    trip_query = Trip.where(from: @from, to: @to)
    @trips = trip_query.order(:start_time)

    @buses = Bus.includes(:services).where(id: trip_query.distinct.select(:bus_id)).index_by(&:id)
  end
end
