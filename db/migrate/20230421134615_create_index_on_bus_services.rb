class CreateIndexOnBusServices < ActiveRecord::Migration[5.2]
  def change
    add_index :buses_services, :bus_id
    add_index :buses_services, :service_id
  end
end