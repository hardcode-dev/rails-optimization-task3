class TripsController < ApplicationController
  helper_method :index_html

  def index
    if index_cache.nil?
      @from = City.find_by_name!(params[:from])
      @to = City.find_by_name!(params[:to])
      @trips = Trip.where(from: @from, to: @to).includes(bus: :services).order(:start_time)

      prepare_index_cache
    end
  end

  private

  def index_cache
    @index_cache ||= Redis.current.get("TripsController#index_#{params[:from].downcase}_#{params[:to].downcase}")
  end

  def index_html
    @index_html ||=
      index_cache || render_to_string(
        "trips/_index",
        locals: {:@from => @from, :@to => @to, :@trips => @trips}
      )
  end

  def prepare_index_cache
    Redis.current.set(
      "TripsController#index_#{params[:from].downcase}_#{params[:to].downcase}",
      index_html, ex: 1.minutes
    )
  end
end
