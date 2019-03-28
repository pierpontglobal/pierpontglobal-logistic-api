class Expense < ApplicationRecord
  belongs_to :charge, :foreign_key => 'charge_id'
end
