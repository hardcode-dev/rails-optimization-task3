class AddUniqIndexToCityName < ActiveRecord::Migration[5.2]
  def change
    add_index :cities, :name, unique: true
  end
end
