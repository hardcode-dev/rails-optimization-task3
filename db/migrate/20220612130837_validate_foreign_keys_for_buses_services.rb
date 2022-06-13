# frozen_string_literal: true

class ValidateForeignKeysForBusesServices < ActiveRecord::Migration[5.2]
  def change
    validate_foreign_key :buses_services, column: :bus_id
    validate_foreign_key :buses_services, column: :service_id
  end
end
