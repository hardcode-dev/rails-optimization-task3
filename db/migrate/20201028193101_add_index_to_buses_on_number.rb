# frozen_string_literal: true

class AddIndexToBusesOnNumber < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :buses, %i[model number], unique: true, algorithm: :concurrently
  end
end
