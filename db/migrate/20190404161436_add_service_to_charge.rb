class AddServiceToCharge < ActiveRecord::Migration[5.2]
  def change
    add_reference :charge, :service, :foreign_key => true
  end
end
