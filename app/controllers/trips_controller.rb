class TripsController < ApplicationController
  before_action :set_pagination_params, :set_cities, only: :index

  def index
    @total_count = Trip.where(from: @from, to: @to).count
    @trips = Trip.where(from: @from, to: @to)
                 .order(:start_time)
                 .limit(@per).offset(@per * (@page - 1))
                 .preload(bus: [:services])
  end

  private

  def set_pagination_params
    @page = params[:page].present? ? params[:page].to_i : 1
    @per = params[:per].present? ? params[:per].to_i : 100
  end

  def set_cities
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])
  end
end
