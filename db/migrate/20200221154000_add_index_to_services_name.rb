class AddIndexToServicesName < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  
  def change
    add_index :services, [:name], unique: true, algorithm: :concurrently
  end
end
