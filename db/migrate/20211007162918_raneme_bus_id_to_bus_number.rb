class RanemeBusIdToBusNumber < ActiveRecord::Migration[5.2]
  def change
    rename_column :trips, :bus_id, :bus_number
    rename_column :buses_services, :bus_id, :bus_number
  end
end
