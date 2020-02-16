class AddIndexNameForCities < ActiveRecord::Migration[5.2]
  def change
    add_index :cities, :name
  end
end
