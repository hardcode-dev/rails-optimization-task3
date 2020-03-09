class AddIndicesToBusServices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def up
    add_index :buses_services, %i[model number service_id], algorithm: :concurrently
    add_index :buses_services, %i[service_id model number], algorithm: :concurrently
    add_index :cities, :name, algorithm: :concurrently
    add_index :trips, %i[from_id to_id], algorithm: :concurrently
  end

  def down
    remove_index :buses_services, %i[model number service_id]
    remove_index :buses_services, %i[service_id model number]
    remove_index :cities, :name
    remove_index :trips, %i[from_id to_id]
  end
end
