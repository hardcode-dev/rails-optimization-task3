class AddFromIdToIdIndexToTrips < ActiveRecord::Migration[5.2]
  def change
    add_index :trips, [:from_id, :to_id]
  end
end
