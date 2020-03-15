class AddIndices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :buses, :number, algorithm: :concurrently
    add_index :trips, [:from_id, :to_id], algorithm: :concurrently
  end
end
