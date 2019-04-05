class Charge < ApplicationRecord
  has_many :incomes
  has_many :expenses
  belongs_to :shippment
  has_one :service
end
