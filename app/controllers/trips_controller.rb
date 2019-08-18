class TripsController < ApplicationController
  def index
    @trips = Trip.preload(:bus).where(from: from, to: to).order(:start_time)
  end

  private

  helper_method :from, :to

  def from
    @from ||= City.find_by_name!(params[:from])
  end

  def to
    @to ||= City.find_by_name!(params[:to])
  end
end
