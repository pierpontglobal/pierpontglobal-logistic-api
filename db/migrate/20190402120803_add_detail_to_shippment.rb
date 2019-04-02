class AddDetailToShippment < ActiveRecord::Migration[5.2]
  def change
    add_column :shippments, :service_type, :string
    add_column :shippments, :destination_name, :string

    add_reference :shippments, :issuing_company, foreign_key: true
    add_reference :shippments, :consignee, foreign_key: true
    add_reference :shippments, :shipper, foreign_key: true
    add_reference :shippments, :agent, :foreign_key => true
    add_reference :shippments, :mode_of_transportation, :foreign_key => true
  end
end
