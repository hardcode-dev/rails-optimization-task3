class AddIndexToNumberInBuses < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :buses, :number, unique: true, algorithm: :concurrently
  end
end
