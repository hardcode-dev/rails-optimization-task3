# frozen_string_literal: true

class AddIndexNumberColumnFromBuses < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!

  def change
    add_index :buses, %i[number model], unique: true, algorithm: :concurrently
  end
end
