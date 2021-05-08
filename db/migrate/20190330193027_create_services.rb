# frozen_string_literal: true

class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
    end
  end
end
