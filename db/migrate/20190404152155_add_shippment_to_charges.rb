class AddShippmentToCharges < ActiveRecord::Migration[5.2]
  def change
    add_reference :charges, :shippment, :foreign_key => true
  end
end
