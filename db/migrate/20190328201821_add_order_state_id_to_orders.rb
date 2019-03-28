class AddOrderStateIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_state_id, :integer
  end
end
