class TripsController < ApplicationController
  def index

    #
    # да этому здесь не место, но будет интересно посмотреть будет ли за это замечание ))
    Rails.logger.level = 5

    @from = City.find_by_name!(params[:from])
    @to = City.find_by_name!(params[:to])


    @trips = Trip.get_data(@from.id, @to.id)
  end
end
