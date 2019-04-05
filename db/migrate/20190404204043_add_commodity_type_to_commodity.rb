class AddCommodityTypeToCommodity < ActiveRecord::Migration[5.2]
  def change
    add_reference :commodities, :commodity_type, :foreign_key => true
  end
end
