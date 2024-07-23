class AddPasswordToCustomerRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :customer_records, :Password, :string
  end
end
