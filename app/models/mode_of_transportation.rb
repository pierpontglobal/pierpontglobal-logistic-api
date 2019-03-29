class ModeOfTransportation < ApplicationRecord
  belongs_to :shippment, :class_name => 'Shippment', :foreign_key => 'shippment_id'
end
