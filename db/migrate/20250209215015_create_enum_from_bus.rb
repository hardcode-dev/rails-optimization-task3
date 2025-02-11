# frozen_string_literal: true

class CreateEnumFromBus < ActiveRecord::Migration[7.2]
  def change
    safety_assured do
      create_enum :mode, Bus::MODELS
    end
  end
end
