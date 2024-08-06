require 'rails_helper'
require 'twilio-ruby'

RSpec.describe OtpService, type: :service do
  let(:phone_number) { '84285208' }
  let(:formatted_phone_number) { '+6584285208' }
  let(:otp_service) { OtpService.new(phone_number) }
  let(:twilio_client) { instance_double(Twilio::REST::Client) }
  let(:verify_service) { double }
  let(:verifications) { double }
  let(:verification_checks) { double }

  before do
    allow(Twilio::REST::Client).to receive(:new).and_return(twilio_client)
    allow(twilio_client).to receive(:verify).and_return(verify_service)
    allow(verify_service).to receive(:v2).and_return(verify_service)
    allow(verify_service).to receive(:services).with(OtpService::SERVICE_SID).and_return(verify_service)
    allow(verify_service).to receive(:verifications).and_return(verifications)
    allow(verify_service).to receive(:verification_checks).and_return(verification_checks)
  end

  describe '#initialize' do
    it 'formats the phone number correctly' do
      expect(otp_service.phone_number).to eq(formatted_phone_number)
    end

    it 'generates an OTP' do
      expect(otp_service.otp.length).to eq(6)
    end
  end

  describe '#send_otp' do
    it 'sends an OTP to the phone number' do
      expect(verifications).to receive(:create).with(to: formatted_phone_number, channel: 'sms').and_return(double(sid: '12345'))
      otp_service.send_otp
    end
  end

  describe '#verify_otp' do
    let(:otp_code) { '123456' }

    it 'returns false if the OTP code is not 6 digits' do
      expect(otp_service.verify_otp('123')).to be false
    end

    it 'verifies the OTP code with Twilio' do
      expect(verification_checks).to receive(:create).with(to: formatted_phone_number, code: otp_code).and_return(double(status: 'approved'))
      expect(otp_service.verify_otp(otp_code)).to be true
    end

    it 'returns false if the verification is not approved' do
      expect(verification_checks).to receive(:create).with(to: formatted_phone_number, code: otp_code).and_return(double(status: 'pending'))
      expect(otp_service.verify_otp(otp_code)).to be false
    end
  end
end