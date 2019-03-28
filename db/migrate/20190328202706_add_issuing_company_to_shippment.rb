class AddIssuingCompanyToShippment < ActiveRecord::Migration[5.2]
  def change
    add_column :shippments, :issuing_company_id, :integer
  end
end
