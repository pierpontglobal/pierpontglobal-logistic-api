class Shipper < ApplicationRecord

  scope :sanitized, lambda {
    select(
        :id,
        :name,
        :address,
        :location,
        :custom_name,
        :place_id,
        :city,
        :vicinity
    )
  }

end
