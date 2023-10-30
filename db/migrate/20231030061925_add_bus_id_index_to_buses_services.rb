class AddBusIdIndexToBusesServices < ActiveRecord::Migration[5.2]
  def change
    add_index :buses_services, :bus_id
  end
end
