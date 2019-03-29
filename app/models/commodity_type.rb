class CommodityType < ApplicationRecord
  belongs_to :commodity, :class_name => 'Commodity', :foreign_key => 'commodity_id'
end
