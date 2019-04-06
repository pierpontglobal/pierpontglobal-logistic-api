class Charge < ApplicationRecord
  belongs_to :shippment
  belongs_to :service
  belongs_to :charge_type
end
