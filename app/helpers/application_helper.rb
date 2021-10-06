# frozen_string_literal: true

module ApplicationHelper
  def helper_arrival_time_calculate(trip)
  	(Time.parse(trip.start_time) + trip.duration_minutes.minutes).strftime('%H:%M')
  end
end
