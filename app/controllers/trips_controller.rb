class TripsController < ApplicationController
  def index
    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])

    @trip_count = Trip.where(from: @from, to: @to).count

    @trips = ActiveRecord::Base.connection.execute(sql_query).to_a
  end

  # binding.pry

  private

  def sql_query
    "SELECT trips.*,
      buses.model,
      buses.number,
      services.name
      FROM trips
      INNER JOIN buses ON buses.id = trips.bus_id
      LEFT OUTER JOIN buses_services ON buses_services.bus_id = buses.id
      LEFT OUTER JOIN services ON buses_services.service_id = services.id
      WHERE trips.from_id = #{@from.id} AND trips.to_id = #{@to.id}
      ORDER BY trips.start_time, trips.id ASC"
  end

end

# Trip.select('trips.*, buses.model, buses.number, services.name').joins(:bus).joins("LEFT OUTER JOIN buses_services ON buses_services.bus_id = buses.id").joins("LEFT OUTER JOIN services ON buses_services.service_id = services.id").where(from: @from, to: @to).order(:start_time).limit(3)


