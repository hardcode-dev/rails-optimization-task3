class AddUniqIndexToBusNumber < ActiveRecord::Migration[5.2]
  def change
    add_index :buses, :number, unique: true
  end
end
