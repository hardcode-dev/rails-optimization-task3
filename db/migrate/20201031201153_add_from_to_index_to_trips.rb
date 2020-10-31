# frozen_string_literal: true

class AddFromToIndexToTrips < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :trips, %i[to_id from_id], algorithm: :concurrently
  end
end
