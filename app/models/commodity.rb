class Commodity < ApplicationRecord
  has_one :commodity_type
  belongs_to :shippment, :foreign_key => 'shippment_id'
end
