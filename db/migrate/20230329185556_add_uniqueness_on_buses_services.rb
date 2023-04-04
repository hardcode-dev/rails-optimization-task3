class AddUniquenessOnBusesServices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :buses_services, %[bus_id, service_id], unique: true, algorithm: :concurrently
  end
end
