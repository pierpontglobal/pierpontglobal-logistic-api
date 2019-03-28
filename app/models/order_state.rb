class OrderState < ApplicationRecord
  belongs_to :worker, :class_name => 'Order', :foreign_key => 'order_id'
end
