class AddIndexToTrips < ActiveRecord::Migration[5.2]
  def change
    add_index :trips, :from_id
    add_index :trips, :to_id
  end
end
