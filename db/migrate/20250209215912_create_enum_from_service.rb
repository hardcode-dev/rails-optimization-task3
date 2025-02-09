class CreateEnumFromService < ActiveRecord::Migration[7.2]
  def change
    safety_assured do
      create_enum :name, Service::SERVICES
    end
  end
end
