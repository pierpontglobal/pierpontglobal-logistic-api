class Charge < ApplicationRecord
  has_many :incomes
  has_many :expenses
  belongs_to :shippment, :foreign_key => 'shippment_id'
end
