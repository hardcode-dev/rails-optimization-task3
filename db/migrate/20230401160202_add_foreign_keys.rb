class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :trips, :cities, column: :from_id, validate: false
    add_foreign_key :trips, :cities, column: :to_id, validate: false
    add_foreign_key :trips, :buses, column: :bus_id, validate: false
  end
end
