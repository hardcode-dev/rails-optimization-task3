class AddIndexOnBusTable < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!


  def change
    add_index :buses, %i[model number], algorithm: :concurrently
  end
end
