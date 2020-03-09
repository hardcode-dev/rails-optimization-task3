class AddIndicesToBusServices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :buses_services, %i[model number service_id], algorithm: :concurrently
    add_index :buses_services, %i[service_id model number], algorithm: :concurrently
    add_index :cities, :name, algorithm: :concurrently
  end
end
