class CreateChargeTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :charge_types do |t|
      t.integer :custom_id
      t.string :name
      t.timestamps
    end
  end
end
