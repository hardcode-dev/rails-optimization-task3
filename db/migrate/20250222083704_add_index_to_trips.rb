class AddIndexToTrips < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :trips, %i[from_id to_id], algorithm: :concurrently, order: { start_time: :asc }
  end
end
