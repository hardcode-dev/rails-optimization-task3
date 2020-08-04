class ChangeRelationIdInStaffings < ActiveRecord::Migration[5.2]
  def change
    change_column :buses_services, :bus_id, :string
    change_column :buses_services, :service_id, :string
  end
end
