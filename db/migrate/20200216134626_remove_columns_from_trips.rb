class RemoveColumnsFromTrips < ActiveRecord::Migration[5.2]
  def change
    safety_assured do
      remove_column :trips, :from_id
      remove_column :trips, :to_id
    end
  end
end
