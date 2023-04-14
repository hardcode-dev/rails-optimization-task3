class AddUniqueNumberIndexToBuses < ActiveRecord::Migration[7.0]
  def change
    add_index :buses, :number, unique: true
  end
end
