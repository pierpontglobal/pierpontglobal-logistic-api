class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charge do |t|
      t.string :type
      t.string :description
      t.integer :quantity
      t.string :unit
      t.decimal :rate
      t.decimal :profit
      t.string :bill_to_name
      t.decimal :quantity_expense
      t.integer :reference

      t.timestamps
    end
  end
end
