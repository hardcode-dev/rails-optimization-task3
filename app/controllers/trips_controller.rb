# frozen_string_literal: true

class TripsController < ApplicationController
  def index
    @from = City.find_by!(name: params[:from])
    @to = City.find_by!(name: params[:to])
    trips = Trip
      .eager_load(bus: :services)
      .where(from: @from, to: @to)
  
    @trips_count = trips.size
    @trips = trips.order(:start_time).page(params[:page]).per(20)
  end
end
