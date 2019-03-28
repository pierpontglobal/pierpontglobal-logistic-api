class CreateIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :incomes do |t|
      t.integer :quantity
      t.string :units
      t.string :rates
      t.decimal :amount
      t.string :currency
      t.string :payment
      t.date :date
      t.string :bill_to_address
      t.string :bill_to_name

      t.timestamps
    end
  end
end
