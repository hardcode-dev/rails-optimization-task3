class ChangeNumberOnBuses < ActiveRecord::Migration[5.2]
  def change
    change_column :buses, :number, :integer, using: 'number::integer'
    add_index :buses, :number
  end
end
