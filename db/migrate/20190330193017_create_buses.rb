class CreateBuses < ActiveRecord::Migration[5.2]
  def change
    create_table :buses do |t|
      t.string :number, index: true
      t.string :model
    end
  end
end
