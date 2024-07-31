# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_30_135856) do
  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "display_name"
    t.string "phone_number"
    t.string "password_digest"
    t.date "dob"
    t.string "fin"
    t.string "country_of_residence"
    t.string "postal_code"
    t.string "block"
    t.string "floor"
    t.string "unit"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "work"
    t.string "industry"
    t.string "tax_resident_country"
    t.string "gender"
    t.string "email"
    t.string "application_status"
    t.string "identity_type"
    t.string "passport_number"
    t.string "nric_number"
    t.string "nationality"
    t.date "passport_expiry_date"
    t.date "application_date"
    t.string "proof_of_identity"
    t.string "proof_of_residential_address"
    t.string "employment_pass"
    t.string "proof_of_mobile_phone_ownership"
    t.string "proof_of_tax_residency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
