class Order < ApplicationRecord
  belongs_to :shippment
  has_one :order_state
  belongs_to :user
end
