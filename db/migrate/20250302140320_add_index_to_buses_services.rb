class AddIndexToBusesServices < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def up
    add_index :buses_services, :bus_id, algorithm: :concurrently
  end

  def down
    remove_index :buses_services, :bus_id, algorithm: :concurrently
  end
end
