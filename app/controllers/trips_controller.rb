class TripsController < ApplicationController
  def index
    cities = City.where(name: [params[:from], params[:to]]).all.index_by(&:name)
    @from = cities.fetch(params[:from])
    @to = cities.fetch(params[:to])
    @trips = Trip.where(from: @from, to: @to).preload(bus: [:services]).order(:start_time)
  end
end
