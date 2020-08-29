class AddFromAndToColumnsToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :from, :string
    add_column :trips, :to, :string
  end
end
