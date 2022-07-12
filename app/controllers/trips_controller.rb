# frozen_string_literal: true

class TripsController < ApplicationController
  Bullet.enable = false

  def index
    @from = City.find_by(name: params[:from])
    @to = City.find_by(name: params[:to])
    @trips = Trip.preload([bus: :services]).where(from: @from, to: @to).order(:start_time).load
  end
end
