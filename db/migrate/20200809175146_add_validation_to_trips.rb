class AddValidationToTrips < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_foreign_key :trips, :cities, column: :from_id
    add_foreign_key :trips, :cities, column: :to_id
    change_column_null :trips, :from_id, false
    change_column_null :trips, :to_id, false
    change_column_null :trips, :duration_minutes, false
    change_column_null :trips, :price_cents, false
    add_index :trips, [:from_id, :to_id], algorithm: :concurrently

    reversible do |dir|
      dir.up do
        execute("ALTER TABLE trips ADD CONSTRAINT check_start_time_with_regex CHECK (start_time ~* '([0-1][0-9]|[2][0-3]):[0-5][0-9]');")
        execute("ALTER TABLE trips ADD CONSTRAINT check_greater_then_zero_duration_minutes CHECK (duration_minutes > 0);")
        execute("ALTER TABLE trips ADD CONSTRAINT check_greater_then_zero_price_cents CHECK (price_cents > 0);")
      end
      dir.down do
        execute("ALTER TABLE trips DROP CONSTRAINT check_start_time_with_regex;")
        execute("ALTER TABLE trips DROP CONSTRAINT check_greater_then_zero_duration_minutes;")
        execute("ALTER TABLE trips DROP CONSTRAINT check_greater_then_zero_price_cents;")
      end
    end
  end
end
