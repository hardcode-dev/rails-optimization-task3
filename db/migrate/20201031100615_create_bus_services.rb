# frozen_string_literal: true

class CreateBusServices < ActiveRecord::Migration[5.2]
  def change
    create_table :bus_services do |t|
      t.belongs_to :service
      t.belongs_to :bus
      t.timestamps
    end
  end
end
