class DropBusesServicesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :buses_services
  end
end
