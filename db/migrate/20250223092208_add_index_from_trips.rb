class AddIndexFromTrips < ActiveRecord::Migration[8.0]
  def change
    add_index :trips, [:from_id, :to_id]
  end
end
