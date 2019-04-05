class AddChargeToIncomeAndExpense < ActiveRecord::Migration[5.2]
  def change
    add_reference :incomes, :charge, :foreign_key => true
    add_reference :expenses, :charge, :foreign_key => true
  end
end
