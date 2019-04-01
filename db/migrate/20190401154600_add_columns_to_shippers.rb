class AddColumnsToShippers < ActiveRecord::Migration[5.2]
  def change
    add_column :shippers, :location, :string
    add_column :shippers, :custom_name, :string
    add_column :shippers, :website, :string
    add_column :shippers, :place_id, :string
  end
end
