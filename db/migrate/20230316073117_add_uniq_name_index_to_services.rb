class AddUniqNameIndexToServices < ActiveRecord::Migration[7.0]
  def change
    add_index :services, :name, unique: true
  end
end
