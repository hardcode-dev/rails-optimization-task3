class TripsController < ApplicationController
  def index
    @from = params[:from]
    @to = params[:to]
    @trips_count = trips_query.count
    @trips = trips_query.order(:start_time)
                        .joins(bus: :services)
                        .select(trips_select.join(','))
                        .group('trips.id, buses.id')
  end

  private

  def trips_query
    @cities ||= City.where(name: [@from, @to]).pluck(:name, :id).to_h
    Trip.where(from_id: @cities[@from], to_id: @cities[@to])
  end

  def trips_select
    [
      'trips.start_time',
      'trips.duration_minutes',
      'trips.price_cents',
      'array_agg(services.name) as service_names',
      'buses.number as bus_number',
      'buses.model as bus_model'
    ]
  end
end
