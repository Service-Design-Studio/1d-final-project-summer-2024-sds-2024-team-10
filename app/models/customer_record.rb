class CustomerRecord < ApplicationRecord
  before_create :set_record_date
  after_create :schedule_deletion

  private

  def set_record_date
    self.record_date ||= Date.today
  end

  def schedule_deletion
    DeleteOldCustomerRecordsJob.set(wait_until: 30.days.from_now).perform_later(self.id)
  end
end
