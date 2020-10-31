class AddIndexOnNameToServices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :services, :name, algorithm: :concurrently
  end
end
