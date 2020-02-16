class DropCities < ActiveRecord::Migration[5.2]
  def change
    drop_table :cities
  end
end
