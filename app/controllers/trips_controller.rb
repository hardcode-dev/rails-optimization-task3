class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])
    @trips = Trip.where(from: @from, to: @to).order(:start_time).includes(bus: [:services])#.paginate(page: params[:page] || 1, per_page: 5)
  end
end
