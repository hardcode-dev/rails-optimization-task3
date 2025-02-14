class AddUniqueIndexToServices < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :services, :name, unique: true, algorithm: :concurrently
  end
end
