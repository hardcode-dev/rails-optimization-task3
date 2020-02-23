class AddServicesToBuses < ActiveRecord::Migration[5.2]
  def change
    add_column :buses, :service_names, :string, array: true
    change_column_default :buses, :service_names, from: nil, to: []
  end
end
