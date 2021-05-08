class TripsController < ApplicationController
  PER_PAGE = 50
  def index
    City.where(name: [params[:from], params[:to]])
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])

    @trips =
      Trip.where(from: @from, to: @to).includes(:bus).order(:start_time).page(params[:page])
    cache_bus_partials
  end

  private

  def cache_bus_partials
    @bus_partials = {}
    @trips.each do |trip|
      @bus_partials[trip.bus.id] ||=
        view_context.render 'trips/services', services: trip.bus.services
    end
  end
end
