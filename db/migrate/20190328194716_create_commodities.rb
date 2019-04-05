class CreateCommodities < ActiveRecord::Migration[5.2]
  def change
    create_table :commodities do |t|
      t.string :reference
      t.integer :pieces
      t.timestamps
    end
  end
end
