class AddServiceToCharge < ActiveRecord::Migration[5.2]
  def change
    add_reference :charges, :service, :foreign_key => true
  end
end
