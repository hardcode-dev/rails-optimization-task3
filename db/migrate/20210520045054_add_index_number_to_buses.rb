class AddIndexNumberToBuses < ActiveRecord::Migration[5.2]
  def change
    add_index :buses, :number
  end
end
