class Order < ApplicationRecord
  belongs_to :shippment
  belongs_to :order_state
  belongs_to :user
  has_many :commodities
end
