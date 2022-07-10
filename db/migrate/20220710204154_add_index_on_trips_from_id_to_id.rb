class AddIndexOnTripsFromIdToId < ActiveRecord::Migration[6.1]
  def change
    add_index :trips, %i[from_id to_id]
  end
end
