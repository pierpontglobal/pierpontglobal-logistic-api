class AddUuidToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uuid, :string
    add_column :users, :provider, :string
  end
end
