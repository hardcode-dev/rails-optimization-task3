class AddIndexeToTrip < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :trips, [:from_id, :to_id], algorithm: :concurrently
  end
end
