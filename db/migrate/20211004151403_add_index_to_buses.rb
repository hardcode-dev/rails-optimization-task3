class AddIndexToBuses < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :buses, [:model, :number], algorithm: :concurrently
  end
end
