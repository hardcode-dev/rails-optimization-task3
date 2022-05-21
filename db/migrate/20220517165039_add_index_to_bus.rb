class AddIndexToBus < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :buses, :number, unique: true, algorithm: :concurrently
  end
end
