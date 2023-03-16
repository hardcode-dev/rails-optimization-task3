class AddUniqueNameIndexToCities < ActiveRecord::Migration[7.0]
  def change
    add_index :cities, :name, unique: true
  end
end
