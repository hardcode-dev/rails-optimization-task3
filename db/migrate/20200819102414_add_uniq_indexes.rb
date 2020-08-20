class AddUniqIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :cities, :name, unique: true
    add_index :buses, [:model, :number], unique: true
    add_index :buses_services, [:bus_id, :service_id], unique: true
    add_index :services, :name, unique: true
  end
end
