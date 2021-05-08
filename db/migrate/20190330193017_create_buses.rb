class CreateBuses < ActiveRecord::Migration[5.2]
  def change
    create_table :buses, id: :uuid do |t|
      t.string :number
      t.string :model
      t.jsonb :services, default: []
    end
  end
end
