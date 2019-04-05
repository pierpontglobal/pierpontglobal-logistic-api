class Commodity < ApplicationRecord
  belongs_to :commodity_type
  belongs_to :shippment
end
