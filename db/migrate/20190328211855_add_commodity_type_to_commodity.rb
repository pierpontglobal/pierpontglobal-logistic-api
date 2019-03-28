class AddCommodityTypeToCommodity < ActiveRecord::Migration[5.2]
  def change
    add_column :commodities, :commodity_type_id, :integer
  end
end
