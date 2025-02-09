class AddIndexFromTrips < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!
  
  def change
    add_index :trips, :from_id, algorithm: :concurrently
    add_index :trips, :to_id, algorithm: :concurrently
    add_index :trips, :bus_id, algorithm: :concurrently
  end
end
