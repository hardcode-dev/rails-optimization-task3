class AddIndexToBus < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :buses, :number, algorithm: :concurrently
  end
end
