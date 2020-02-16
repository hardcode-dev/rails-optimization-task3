class AddServicesToBuses < ActiveRecord::Migration[5.2]
  def change
    add_column :buses, :services, :string, array: true
  end
end
