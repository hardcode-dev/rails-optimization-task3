# frozen_string_literal: true

class ValidateAddForeignKeyFromCityAndToCityToTrips < ActiveRecord::Migration[5.2]
  def change
    validate_foreign_key :trips, column: :from_id
    validate_foreign_key :trips, column: :to_id
  end
end
