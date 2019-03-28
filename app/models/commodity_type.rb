class CommodityType < ApplicationRecord
  belongs_to :worker, :class_name => 'Commodity', :foreign_key => 'commodity_id'
end
