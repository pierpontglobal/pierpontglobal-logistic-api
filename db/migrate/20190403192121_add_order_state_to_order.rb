class AddOrderStateToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :order_state, :foreign_key => true
  end
end
