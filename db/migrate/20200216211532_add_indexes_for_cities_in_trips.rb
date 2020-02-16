class AddIndexesForCitiesInTrips < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def up
    add_index :trips, [:from, :to], algorithm: :concurrently
  end

  def down
    remove_index :trips, [:from, :to]
  end
end
