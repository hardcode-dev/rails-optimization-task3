class AddIndexToStaffing < ActiveRecord::Migration[5.2]
  def change
    add_index :buses_services, [:bus_id, :service_id]
  end
end
