class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.string :status
      t.string :code
      t.string :description
      t.integer :quantity
      t.string :unit
      t.decimal :rate
      t.decimal :profit
      t.string :bill_to_name
      t.decimal :quantity_expense

      t.timestamps
    end
  end
end
