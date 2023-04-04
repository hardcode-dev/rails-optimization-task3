class AddIndexesToTrips < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :trips, %i[from_id to_id], algorithm: :concurrently
  end
end
