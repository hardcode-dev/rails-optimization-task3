class AddIndexToBusServices < ActiveRecord::Migration[5.2]
  def change
    add_index :buses_services, [:service_id, :bus_id]
  end
end
