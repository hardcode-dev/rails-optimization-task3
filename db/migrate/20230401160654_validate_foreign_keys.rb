class ValidateForeignKeys < ActiveRecord::Migration[5.2]
  def change
    validate_foreign_key :trips, :cities
    validate_foreign_key :trips, :buses
  end
end
