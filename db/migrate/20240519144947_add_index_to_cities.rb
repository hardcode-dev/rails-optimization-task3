class AddIndexToCities < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :cities, :name, unique: true, algorithm: :concurrently
  end
end
