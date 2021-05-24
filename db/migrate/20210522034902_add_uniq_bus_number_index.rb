class AddUniqBusNumberIndex < ActiveRecord::Migration[5.2]
  def up
    remove_index :buses, :number
    add_index :buses, :number, unique: true
  end

  def down
    remove_index :buses, :number, unique: true
    add_index :buses, :number
  end
end
