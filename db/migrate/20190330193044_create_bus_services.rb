class CreateBusServices < ActiveRecord::Migration[5.2]
  def change
    create_table :bus_services do |t|
      t.belongs_to :bus
      t.belongs_to :service
    end
  end
end
