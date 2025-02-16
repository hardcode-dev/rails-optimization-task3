class AddIndexToTripsFromIdAndToId < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :trips, %i[from_id to_id start_time], order: {start_time: :asc}, algorithm: :concurrently
  end
end
