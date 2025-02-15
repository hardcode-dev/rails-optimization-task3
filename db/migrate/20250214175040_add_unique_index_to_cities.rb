class AddUniqueIndexToCities < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :cities, :name, unique: true, algorithm: :concurrently
  end
end
