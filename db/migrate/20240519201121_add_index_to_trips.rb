class AddIndexToTrips < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :trips, [:from_id, :to_id, :bus_id, :start_time], unique: true, algorithm: :concurrently
  end
end
