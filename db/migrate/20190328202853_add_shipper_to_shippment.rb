class AddShipperToShippment < ActiveRecord::Migration[5.2]
  def change
    add_column :shippments, :shipper_id, :integer
  end
end
