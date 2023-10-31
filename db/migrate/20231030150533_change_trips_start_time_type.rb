class ChangeTripsStartTimeType < ActiveRecord::Migration[5.2]
  def up
    # add a temporary column
    add_column :trips, :start_time_time, :time

    # add the the current start_time as datetime to the temporary column for each entry
    Trip.all.each do |trip|
      trip.update(start_time_time: Time.parse(trip.start_time))
    end

    # drop the old time column
    remove_column :trips, :start_time

    # rename the temporary column to start_time
    rename_column :trips, :start_time_time, :start_time
  end

  def down
    add_column :trips, :start_time_time, :time

    Trip.all.each do |trip|
      trip.update(start_time_time: Time.parse(trip.start_time).strftime('%H:%M'))
    end

    remove_column :trips, :start_time
    rename_column :trips, :start_time_time, :start_time
  end
end
