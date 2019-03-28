class AddServiceToShippment < ActiveRecord::Migration[5.2]
  def change
    add_column :shippments, :service_id, :integer
  end
end
