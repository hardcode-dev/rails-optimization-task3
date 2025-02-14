class AddUniqueIndexToBusNumbers < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :buses, :number, unique: true, algorithm: :concurrently
  end
end
