class AddModeOfTransportationToShippment < ActiveRecord::Migration[5.2]
  def change
    add_column :shippments, :mode_of_transportation_id, :integer
  end
end
