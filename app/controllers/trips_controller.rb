class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])
    @services = Service.pluck(:id, :name).to_h
    @trips = Trip.where(from: @from, to: @to).preload(bus: :bus_services).order(:start_time)
  end
end
