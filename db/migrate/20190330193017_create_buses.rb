class CreateBuses < ActiveRecord::Migration[5.2]
  def change
    create_table :buses do |t|
      t.string :number, uniqueness: true
      t.string :model
      t.integer :services, array: true
    end
  end
end
