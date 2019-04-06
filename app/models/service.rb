class Service < ApplicationRecord
  has_many :shippments
  has_many :charges
end
