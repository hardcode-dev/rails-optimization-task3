class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])
    @trips = Trip.where(from: @from, to: @to).order(:start_time).includes([:bus => :services]).map do |trip|
      bus = trip.bus
      services = bus.services.pluck(:name)
      hours, minutes = trip.duration_minutes.divmod(60)
      rub, cop = trip.price_cents.divmod(100)
      {
        bus: bus,
        services: services,
        start_time: trip.start_time,
        duration_hours: hours,
        duration_minutes: minutes,
        price_rub: rub,
        price_cop: cop
      }
    end
  end
end
