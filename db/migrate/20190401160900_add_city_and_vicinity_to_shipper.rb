class AddCityAndVicinityToShipper < ActiveRecord::Migration[5.2]
  def change
    add_column :shippers, :city, :string
    add_column :shippers, :vicinity, :string
  end
end
