class Shippment < ApplicationRecord
  belongs_to :order, :class_name => 'Order', :foreign_key => 'order_id'
  has_one  :mode_of_transportation
  has_many :charges
  has_many :commodities
end
