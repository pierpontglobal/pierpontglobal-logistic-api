class CreateIssuingCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :issuing_companies do |t|
      t.string :company_name
      t.string :company_location

      t.timestamps
    end
  end
end
