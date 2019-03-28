class CreateShippments < ActiveRecord::Migration[5.2]
  def change
    create_table :shippments do |t|
      t.integer :order_number
      t.string :origin_name

      t.timestamps
    end
  end
end
