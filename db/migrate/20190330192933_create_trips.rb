class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.uuid :from_id
      t.uuid :to_id
      t.string :start_time
      t.integer :duration_minutes
      t.integer :price_cents
      t.uuid :bus_id

      t.index [:from_id, :to_id]
    end
  end
end
