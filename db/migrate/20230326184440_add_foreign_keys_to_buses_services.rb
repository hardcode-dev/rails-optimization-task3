class AddForeignKeysToBusesServices < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :buses_services, :buses, on_delete: :cascade, validate: false
    add_foreign_key :buses_services, :services, on_delete: :cascade, validate: false
  end
end
