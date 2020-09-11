class AddIndices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :cities, :name, algorithm: :concurrently
    add_index :buses, :id, algorithm: :concurrently
    add_index :trips, [:from_id, :to_id], algorithm: :concurrently
  end
end
