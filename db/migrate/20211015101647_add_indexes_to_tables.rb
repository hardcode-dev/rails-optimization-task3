class AddIndexesToTables < ActiveRecord::Migration[5.2]
  def change
    add_index :buses, :number, unique: true
    add_index :buses_services, %i[bus_id service_id], unique: true
    add_index :buses_services, %i[service_id bus_id], unique: true
    add_index :cities, :name, unique: true
    add_index :services, :name
    add_index :trips, :from_id
    add_index :trips, :to_id
    add_index :trips, :bus_id
  end
end
