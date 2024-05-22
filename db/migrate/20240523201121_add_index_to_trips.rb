class AddIndexToTrips < ActiveRecord::Migration[6.1]
  def change
    add_index :trips, [:from_id, :to_id, :bus_id, :start_time], unique: true
  end
end
