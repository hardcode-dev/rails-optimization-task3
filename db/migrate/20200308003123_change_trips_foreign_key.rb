class ChangeTripsForeignKey < ActiveRecord::Migration[5.2]
  def up
    add_column :trips, :model, :string
    add_column :trips, :number, :string
    remove_column :trips, :bus_id
    execute 'ALTER TABLE trips ADD CONSTRAINT trips_fk FOREIGN KEY (model,"number") REFERENCES buses(model,"number");'
  end

  def down
    execute 'ALTER TABLE trips DROP CONSTRAINT trips_fk;'
    remove_column :trips, :model
    remove_column :trips, :number
    add_column :trips, :bus_id, :integer
  end
end
