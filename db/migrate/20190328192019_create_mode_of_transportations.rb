class CreateModeOfTransportations < ActiveRecord::Migration[5.2]
  def change
    create_table :mode_of_transportations do |t|
      t.string :name

      t.timestamps
    end
  end
end
