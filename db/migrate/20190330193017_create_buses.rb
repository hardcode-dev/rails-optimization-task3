class CreateBuses < ActiveRecord::Migration[5.2]
  def change
    create_table :buses do |t|
      t.integer :number, unique: true
      t.integer :model
    end
  end
end
