class AddIndicesToEverywhere < ActiveRecord::Migration[5.2]
  def change
    add_index :cities, :name
    add_index :trips, [:to_id, :from_id, :start_time]
    add_index :buses_services, :bus_id
  end
end
