class AddIndexToBusesServices < ActiveRecord::Migration[5.2]
  def change
    add_index :buses_services, :bus_number
  end
end
