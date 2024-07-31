class User < ApplicationRecord
  # has_secure_password

  # validates :full_name, :display_name, :phone_number, :dob, :fin, :country_of_residence, :postal_code, :block, :floor, :unit, :address_line_1, :address_line_2, :work, :industry, :tax_resident_country, :gender, :email, :application_status, :identity_type, :passport_number, :nric_number, :nationality, :passport_expiry_date, :application_date, :proof_of_identity, :proof_of_residential_address, :employment_pass, :proof_of_mobile_phone_ownership, :proof_of_tax_residency, presence: true

  # validates :email, uniqueness: true
  # validates :password, length: { minimum: 6 }
end
