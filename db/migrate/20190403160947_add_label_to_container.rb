class AddLabelToContainer < ActiveRecord::Migration[5.2]
  def change
    add_column :containers, :description, :string
  end
end
