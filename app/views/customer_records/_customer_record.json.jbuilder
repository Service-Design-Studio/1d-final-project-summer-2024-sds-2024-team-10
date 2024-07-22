json.extract! customer_record, :id, :Identification, :Name, :PassportNo, :Nationality, :FIN, :DOD, :TelNo, :Address, :TaxID, :Accountpin, :created_at, :updated_at
json.url customer_record_url(customer_record, format: :json)
