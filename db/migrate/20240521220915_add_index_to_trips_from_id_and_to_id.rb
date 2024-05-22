class AddIndexToTripsFromIdAndToId < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :trips, [:from_id, :to_id], unique: false, algorithm: :concurrently
  end
end
