class AddIndicies < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :buses, %i[model number], unique: true, algorithm: :concurrently
    add_index :buses_services, %i[bus_id service_id], algorithm: :concurrently
    add_index :cities, :name, unique: true, algorithm: :concurrently
    add_index :services, :name, unique: true, algorithm: :concurrently
    add_index :trips, %i[from_id to_id], algorithm: :concurrently
  end
end
