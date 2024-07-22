require "application_system_test_case"

class CustomerRecordsTest < ApplicationSystemTestCase
  setup do
    @customer_record = customer_records(:one)
  end

  test "visiting the index" do
    visit customer_records_url
    assert_selector "h1", text: "Customer records"
  end

  test "should create customer record" do
    visit customer_records_url
    click_on "New customer record"

    fill_in "Accountpin", with: @customer_record.Accountpin
    fill_in "Address", with: @customer_record.Address
    fill_in "Dod", with: @customer_record.DOD
    fill_in "Fin", with: @customer_record.FIN
    fill_in "Identification", with: @customer_record.Identification
    fill_in "Name", with: @customer_record.Name
    fill_in "Nationality", with: @customer_record.Nationality
    fill_in "Passportno", with: @customer_record.PassportNo
    fill_in "Taxid", with: @customer_record.TaxID
    fill_in "Telno", with: @customer_record.TelNo
    click_on "Create Customer record"

    assert_text "Customer record was successfully created"
    click_on "Back"
  end

  test "should update Customer record" do
    visit customer_record_url(@customer_record)
    click_on "Edit this customer record", match: :first

    fill_in "Accountpin", with: @customer_record.Accountpin
    fill_in "Address", with: @customer_record.Address
    fill_in "Dod", with: @customer_record.DOD
    fill_in "Fin", with: @customer_record.FIN
    fill_in "Identification", with: @customer_record.Identification
    fill_in "Name", with: @customer_record.Name
    fill_in "Nationality", with: @customer_record.Nationality
    fill_in "Passportno", with: @customer_record.PassportNo
    fill_in "Taxid", with: @customer_record.TaxID
    fill_in "Telno", with: @customer_record.TelNo
    click_on "Update Customer record"

    assert_text "Customer record was successfully updated"
    click_on "Back"
  end

  test "should destroy Customer record" do
    visit customer_record_url(@customer_record)
    click_on "Destroy this customer record", match: :first

    assert_text "Customer record was successfully destroyed"
  end
end
