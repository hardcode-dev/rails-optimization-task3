# frozen_string_literal: true

class AddIndexFromServices < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!

  def change
    add_index :services, :name, unique: true, algorithm: :concurrently
  end
end
