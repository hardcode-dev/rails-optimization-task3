class CreateTrips < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    create_table :trips do |t|
      t.integer :from_id, foreign_key: true, null: false
      t.integer :to_id, foreign_key: true, null: false
      t.string :start_time
      t.integer :duration_minutes
      t.integer :price_cents
      t.references :bus
    end

    add_index :trips, [:from_id, :to_id, :start_time], algorithm: :concurrently
  end
end
