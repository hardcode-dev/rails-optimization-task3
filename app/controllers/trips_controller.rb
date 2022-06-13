# frozen_string_literal: true

class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])
    @trips = Trip.includes(bus: %i[services]).where(from: @from, to: @to).order(:start_time)
  end
end
