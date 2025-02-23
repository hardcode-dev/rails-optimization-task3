class AddIndexToCitiesOnName < ActiveRecord::Migration[8.0]
  def change
    add_index :cities, :name, unique: true
  end
end
