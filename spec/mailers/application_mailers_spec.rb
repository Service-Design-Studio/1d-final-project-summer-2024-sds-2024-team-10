require 'rails_helper'
require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  describe 'default settings' do
    it 'sets the default from address' do
      expect(ApplicationMailer.default[:from]).to eq('from@example.com')
    end

    it 'uses the mailer layout' do
      mail = ApplicationMailer.sample_email
      expect(mail.body.encoded).to include("This is a sample email body.")
    end
  end
end