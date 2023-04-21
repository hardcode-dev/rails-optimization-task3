class CreateIndexOnTrips < ActiveRecord::Migration[5.2]
  def change
    add_index :trips, :bus_id
    add_index :trips, [:from_id, :to_id]
    add_index :trips, :start_time
  end
end