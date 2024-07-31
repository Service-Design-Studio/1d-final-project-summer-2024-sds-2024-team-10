class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :display_name
      t.string :phone_number
      t.string :password_digest
      t.date :dob
      t.string :fin
      t.string :country_of_residence
      t.string :postal_code
      t.string :block
      t.string :floor
      t.string :unit
      t.string :address_line_1
      t.string :address_line_2
      t.string :work
      t.string :industry
      t.string :tax_resident_country
      t.string :tin
      t.string :gender
      t.string :email
      t.string :application_status
      t.string :identity_type
      t.string :passport_number
      t.string :nric_number
      t.string :nationality
      t.date :passport_expiry_date
      t.date :application_date
      t.string :proof_of_identity
      t.string :proof_of_residential_address
      t.string :employment_pass
      t.string :proof_of_mobile_phone_ownership
      t.string :proof_of_tax_residency

      t.timestamps
    end
  end
end
