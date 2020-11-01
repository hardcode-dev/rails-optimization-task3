# frozen_string_literal: true

class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])
    @trips = Trip.with_bus.where(from: @from, to: @to).order(:start_time).load
    @trip_count = @trips.length
    @from_name = @from.name
    @to_name = @to.name
  end
end
