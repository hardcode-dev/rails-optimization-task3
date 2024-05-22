class AddIndexToBuses < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :buses, [:number, :model], unique: true, algorithm: :concurrently
  end
end
