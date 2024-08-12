require 'rails_helper'

RSpec.describe OtpController, type: :controller do
  let(:phone_number) { '84285208' }
  let(:otp_code) { '123456' }
  let(:otp_service) { instance_double(OtpService) }

  before do
    session[:phone_number] = phone_number
    allow(OtpService).to receive(:new).with(phone_number).and_return(otp_service)
  end

  describe 'POST #create' do
    context 'when OTP generation is successful' do
      before do
        allow(otp_service).to receive(:send_otp)
        post :create
      end

      it 'calls the OtpService to send the OTP' do
        expect(OtpService).to have_received(:new).with(phone_number)
        expect(otp_service).to have_received(:send_otp)
      end

      it 'redirects to the OTP verification path' do
        expect(response).to redirect_to(otp_verification_path)
      end
    end

    context 'when OTP generation raises an ArgumentError' do
      before do
        allow(otp_service).to receive(:send_otp).and_raise(ArgumentError.new('Invalid phone number'))
        post :create
      end

      it 'sets a flash alert with the error message' do
        expect(flash[:alert]).to eq('Invalid phone number')
      end

      it 'redirects to the login path' do
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST #verify_otp' do
    before do
      allow(otp_service).to receive(:verify_otp).with(otp_code).and_return(otp_verified)
      post :verify_otp, params: { otp: otp_code }
    end

    context 'when OTP verification is successful' do
      let(:otp_verified) { true }

      it 'calls the OtpService to verify the OTP' do
        expect(OtpService).to have_received(:new).with(phone_number)
        expect(otp_service).to have_received(:verify_otp).with(otp_code)
      end

      it 'redirects to the singpass path' do
        expect(response).to redirect_to(singpass_path)
      end
    end

    context 'when OTP verification fails' do
      let(:otp_verified) { false }

      it 'redirects to the OTP verification path' do
        expect(response).to redirect_to(otp_verification_path)
      end
    end
  end
end