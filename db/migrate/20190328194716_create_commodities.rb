class CreateCommodities < ActiveRecord::Migration[5.2]
  def change
    create_table :commodities do |t|
      t.string :status
      t.integer :reference
      t.integer :pieaces
      t.string :package
      t.string :description
      t.string :dimension
      t.decimal :weight
      t.decimal :volume

      t.timestamps
    end
  end
end
