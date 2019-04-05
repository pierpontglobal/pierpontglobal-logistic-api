class Service < ApplicationRecord
  has_many :shippment
  has_many :charges
end
