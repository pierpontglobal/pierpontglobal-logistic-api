class ModeOfTransportation < ApplicationRecord
  belongs_to :worker, :class_name => 'Shippment', :foreign_key => 'shippment_id'
end
