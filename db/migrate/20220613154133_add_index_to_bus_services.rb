class AddIndexToBusServices < ActiveRecord::Migration[6.0]
  def change
    add_index :buses_services, :bus_id
  end
end
