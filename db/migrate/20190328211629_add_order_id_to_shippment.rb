class AddOrderIdToShippment < ActiveRecord::Migration[5.2]
  def change
    add_column :shippments, :order_id, :integer
  end
end
