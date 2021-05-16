class AddAbsentTripIndex < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    safety_assured do
      add_index :trips, %i[from_id to_id], algorithm: :concurrently
    end
  end
end
