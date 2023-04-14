class AddUniqueIndexToBusesServices < ActiveRecord::Migration[7.0]
  def change
    add_index :buses_services, [:bus_id, :service_id], unique: true
  end
end
