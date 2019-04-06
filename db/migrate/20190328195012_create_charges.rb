class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.string :description
      t.integer :quantity
      t.string :unit
      t.decimal :rate
      t.decimal :profit
      t.string :bill_to_name
      t.decimal :quantity_expense
      t.integer :reference
      t.string :vendor
      t.string :bill_to
      t.decimal :amount
      t.string :currency
      t.decimal :payment

      t.timestamps
    end
  end
end
