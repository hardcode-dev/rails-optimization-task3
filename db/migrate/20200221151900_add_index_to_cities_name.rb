class AddIndexToCitiesName < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  
  def change
    add_index :cities, [:name], unique: true, algorithm: :concurrently
  end
end
