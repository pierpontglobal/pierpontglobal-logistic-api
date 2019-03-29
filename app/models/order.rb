class Order < ApplicationRecord
  has_one :shippment
  has_one :order_state
  belongs_to :user
end
