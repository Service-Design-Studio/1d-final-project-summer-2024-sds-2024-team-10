require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  it 'inherits from ActiveJob::Base' do
    expect(ApplicationJob.superclass).to eq(ActiveJob::Base)
  end

  # Uncomment and adapt these tests if retry_on and discard_on are used in ApplicationJob
  # it 'retries on ActiveRecord::Deadlocked' do
  #   expect(ApplicationJob.retry_on.include?(ActiveRecord::Deadlocked)).to be_truthy
  # end

  # it 'discards on ActiveJob::DeserializationError' do
  #   expect(ApplicationJob.discard_on.include?(ActiveJob::DeserializationError)).to be_truthy
  # end
end
