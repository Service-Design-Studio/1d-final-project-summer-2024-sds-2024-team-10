class CreateCustomerRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :customer_records do |t|
      t.string :Identification
      t.string :Name
      t.string :PassportNo
      t.string :Nationality
      t.string :FIN
      t.string :DOD
      t.string :TelNo
      t.string :Address
      t.string :TaxID
      t.string :Accountpin

      t.timestamps
    end
  end
end
