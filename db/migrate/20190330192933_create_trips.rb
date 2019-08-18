class CreateTrips < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    create_table :trips do |t|
      t.integer :from_id
      t.integer :to_id
      t.string :start_time
      t.integer :duration_minutes
      t.integer :price_cents
      t.integer :bus_id
    end

    add_index :trips, [:from_id, :to_id, :start_time], algorithm: :concurrently
  end
end
