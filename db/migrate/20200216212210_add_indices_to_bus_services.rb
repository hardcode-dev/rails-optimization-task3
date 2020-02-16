class AddIndicesToBusServices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :buses_services, %i[bus_id service_id], algorithm: :concurrently
    add_index :buses_services, %i[service_id bus_id], algorithm: :concurrently
    add_index :cities, :name, algorithm: :concurrently
  end
end
