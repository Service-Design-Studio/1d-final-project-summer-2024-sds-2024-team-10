class AddRecordDateToCustomerRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :customer_records, :record_date, :date
  end
end
