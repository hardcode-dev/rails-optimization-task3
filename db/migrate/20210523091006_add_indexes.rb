# frozen_string_literal: true

class AddIndexes < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :buses_services, [:bus_id, :service_id], algorithm: :concurrently
    add_index :trips, [:from_id, :to_id], algorithm: :concurrently
  end
end
