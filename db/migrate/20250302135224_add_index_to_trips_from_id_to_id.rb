class AddIndexToTripsFromIdToId < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def up
    add_index :trips, [:from_id, :to_id], algorithm: :concurrently
  end

  def down
    remove_index :trips, [:from_id, :to_id], algorithm: :concurrently
  end
end
