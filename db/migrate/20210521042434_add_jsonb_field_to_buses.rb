class AddJsonbFieldToBuses < ActiveRecord::Migration[5.2]
  def change
    add_column :buses, :services, :jsonb
    change_column_default :buses, :services, from: nil, to: []
  end
end
