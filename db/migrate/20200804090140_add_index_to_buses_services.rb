class AddIndexToBusesServices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index(:buses_services, :bus_id, algorithm: :concurrently)
  end
end
