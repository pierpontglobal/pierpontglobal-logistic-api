class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.integer :quantity
      t.string :units
      t.string :rates
      t.decimal :amount
      t.string :currency
      t.string :payment
      t.date :date
      t.string :vendor

      t.timestamps
    end
  end
end
