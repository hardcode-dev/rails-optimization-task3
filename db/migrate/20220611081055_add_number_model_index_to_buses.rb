class AddNumberModelIndexToBuses < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :buses, [:number, :model], algorithm: :concurrently
  end
end
