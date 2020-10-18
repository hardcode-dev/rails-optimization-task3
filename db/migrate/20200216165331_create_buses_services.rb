class CreateBusesServices < ActiveRecord::Migration[5.2]
  def change
    create_table :buses_services do |t|
      t.belongs_to :bus, foreign_key: true
      t.belongs_to :service, foreign_key: true

      t.timestamps
    end
  end
end
