# spec/controllers/otp_controller_spec.rb
require 'rails_helper'

RSpec.describe OtpController, type: :controller do
  let(:phone_number) { "1234567890" }

  before do
    allow_any_instance_of(OtpService).to receive(:send_otp)
    allow_any_instance_of(OtpService).to receive(:verify_otp).and_return(true)
    session[:phone_number] = phone_number
  end

  describe 'POST #create' do
    context 'when OTP generation is successful' do
      it 'logs the phone number' do
        expect { post :create }.to output(/1234567890/).to_stdout
      end

      it 'logs OTP generation message' do
        expect { post :create }.to output(/otp generated/).to_stdout
      end

      it 'redirects to otp_verification_path' do
        post :create
        expect(response).to redirect_to(otp_verification_path)
      end
    end

    context 'when OTP generation raises an error' do
      before do
        allow_any_instance_of(OtpService).to receive(:send_otp).and_raise(ArgumentError, "Invalid phone number")
      end

      it 'sets the flash alert' do
        post :create
        expect(flash[:alert]).to eq("Invalid phone number")
      end

      it 'redirects to login_path' do
        post :create
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST #verify_otp' do
    context 'when OTP verification is successful' do
      it 'logs OTP verified message' do
        expect { post :verify_otp, params: { otp: "123456" } }.to output(/otp verified/).to_stdout
      end

      it 'redirects to singpass_path' do
        post :verify_otp, params: { otp: "123456" }
        expect(response).to redirect_to(singpass_path)
      end
    end

    context 'when OTP verification fails' do
      before do
        allow_any_instance_of(OtpService).to receive(:verify_otp).and_return(false)
      end

      it 'does not log OTP verified message' do
        expect { post :verify_otp, params: { otp: "123456" } }.to_not output(/otp verified/).to_stdout
      end

      it 'redirects to otp_verification_path' do
        post :verify_otp, params: { otp: "123456" }
        expect(response).to redirect_to(otp_verification_path)
      end
    end
  end
end
