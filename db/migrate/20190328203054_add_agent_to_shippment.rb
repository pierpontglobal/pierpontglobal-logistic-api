class AddAgentToShippment < ActiveRecord::Migration[5.2]
  def change
    add_column :shippments, :agent_id, :integer
  end
end
