require "test_helper"

class CustomerRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer_record = customer_records(:one)
  end

  test "should get index" do
    get customer_records_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_record_url
    assert_response :success
  end

  test "should create customer_record" do
    assert_difference("CustomerRecord.count") do
      post customer_records_url, params: { customer_record: { Accountpin: @customer_record.Accountpin, Address: @customer_record.Address, DOD: @customer_record.DOD, FIN: @customer_record.FIN, Identification: @customer_record.Identification, Name: @customer_record.Name, Nationality: @customer_record.Nationality, PassportNo: @customer_record.PassportNo, TaxID: @customer_record.TaxID, TelNo: @customer_record.TelNo } }
    end

    assert_redirected_to customer_record_url(CustomerRecord.last)
  end

  test "should show customer_record" do
    get customer_record_url(@customer_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_record_url(@customer_record)
    assert_response :success
  end

  test "should update customer_record" do
    patch customer_record_url(@customer_record), params: { customer_record: { Accountpin: @customer_record.Accountpin, Address: @customer_record.Address, DOD: @customer_record.DOD, FIN: @customer_record.FIN, Identification: @customer_record.Identification, Name: @customer_record.Name, Nationality: @customer_record.Nationality, PassportNo: @customer_record.PassportNo, TaxID: @customer_record.TaxID, TelNo: @customer_record.TelNo } }
    assert_redirected_to customer_record_url(@customer_record)
  end

  test "should destroy customer_record" do
    assert_difference("CustomerRecord.count", -1) do
      delete customer_record_url(@customer_record)
    end

    assert_redirected_to customer_records_url
  end
end
