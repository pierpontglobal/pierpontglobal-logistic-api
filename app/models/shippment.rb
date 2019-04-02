class Shippment < ApplicationRecord
  belongs_to :order, :class_name => 'Order', :foreign_key => 'order_id'
  has_one  :mode_of_transportation
  has_many :charges
  has_many :commodities

  scope :sanitized, lambda {
    select(
        :id,
        :order_number,
        :service_type,
        :created_at,
        :destination_name,
        :origin_name,
        :issuing_company_id,
        :consignee_id,
        :shipper_id,
        :agent_id,
        :mode_of_transportation_id
    )
  }

end
