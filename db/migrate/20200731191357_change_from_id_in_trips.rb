class ChangeFromIdInTrips < ActiveRecord::Migration[5.2]
  def change
    change_column :trips, :from_id, :string
    change_column :trips, :to_id, :string
  end
end
