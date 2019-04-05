class CreateCommodityTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :commodity_types do |t|
      t.string :name
      t.integer :custom_id
      t.timestamps
    end
  end
end
