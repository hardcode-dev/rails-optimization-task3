class AddIndexToBusesServices < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :buses_services, :bus_id, algorithm: :concurrently
  end
end
