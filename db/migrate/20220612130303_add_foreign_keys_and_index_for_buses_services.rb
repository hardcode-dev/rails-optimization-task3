# frozen_string_literal: true

class AddForeignKeysAndIndexForBusesServices < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_foreign_key :buses_services, :buses, column: :bus_id, validate: false
    add_foreign_key :buses_services, :services, column: :service_id, validate: false

    add_index :buses_services, %i[bus_id service_id], unique: true, algorithm: :concurrently
  end
end
