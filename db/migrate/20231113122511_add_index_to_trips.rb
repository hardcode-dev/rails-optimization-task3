class AddIndexToTrips < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :trips, [:from_id, :to_id, :start_time], algorithm: :concurrently
  end
end
