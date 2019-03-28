class AddConsigneeToShippment < ActiveRecord::Migration[5.2]
  def change
    add_column :shippments, :consignee_id, :integer
  end
end
