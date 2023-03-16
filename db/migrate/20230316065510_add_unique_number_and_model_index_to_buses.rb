class AddUniqueNumberAndModelIndexToBuses < ActiveRecord::Migration[7.0]
  def change
    add_index :buses, [:number, :model], unique: true
  end
end
