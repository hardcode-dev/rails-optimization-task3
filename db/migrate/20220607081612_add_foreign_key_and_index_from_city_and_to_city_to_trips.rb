# frozen_string_literal: true

class AddForeignKeyAndIndexFromCityAndToCityToTrips < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_foreign_key :trips, :cities, column: :from_id, on_delete: :cascade, validate: false
    add_foreign_key :trips, :cities, column: :to_id, on_delete: :cascade, validate: false

    add_index :trips, %i[from_id to_id], algorithm: :concurrently
  end
end
