class TripsController < ApplicationController
  def index
    @from  = City[params[:from]]
    @to    = City[params[:to]]
    @trips = Trip.connection.execute("
      SELECT * FROM (
        SELECT t.id, t.start_time, t.duration_minutes, t.price_cents, t.bus_id,
               array_agg(bs.service_id) as bus_services,
               b.number as bus_number,
               b.model as bus_model
        FROM trips t
            join buses b on t.bus_id = b.id
            join bus_services bs on t.bus_id = bs.bus_id
        where t.from_id = #{@from.id} and t.to_id = #{@to.id}
        GROUP BY t.id, b.number, b.model
      ) AS a ORDER BY start_time
    ")
  end
end
