class Shippment < ApplicationRecord
  has_one :order
  has_many :charges
  has_many :commodities
  belongs_to :consignee
  belongs_to :agent
  belongs_to :mode_of_transportation
  belongs_to :issuing_company
  belongs_to :shipper

  scope :sanitized, lambda {
    select(
        :id,
        :order_number,
        :service_type,
        :created_at,
        :destination_name,
        :origin_name
    )
  }

end
