class DeleteOldCustomerRecordsJob < ApplicationJob
  queue_as :default

  def perform(customer_record_id)
    customer_record = CustomerRecord.find_by(id: customer_record_id)
    customer_record&.destroy
  end
end
