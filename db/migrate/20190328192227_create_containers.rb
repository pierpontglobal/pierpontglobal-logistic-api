class CreateContainers < ActiveRecord::Migration[5.2]
  def change
    create_table :containers do |t|
      t.decimal :length
      t.decimal :width
      t.decimal :height
      t.decimal :tare_weight
      t.decimal :next_weight
      t.decimal :total_weight
      t.decimal :volume
      t.decimal :vol_weight
      t.decimal :square_pt

      t.timestamps
    end
  end
end
