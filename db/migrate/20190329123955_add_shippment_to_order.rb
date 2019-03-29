class AddShippmentToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :shippment, foreign_key: true
  end
end
