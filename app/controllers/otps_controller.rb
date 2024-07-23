class OtpsController < ApplicationController
  def create
    phone_number = params[:phone_number]
    otp_service = OtpService.new(phone_number)
    otp_service.send_otp

    session[:phone_number] = phone_number

    redirect_to verify_otps_path
  rescue ArgumentError => e
    flash[:alert] = e.message
    redirect_to new_otps_path
  end

  def verify
  end

  def verify_otp
    phone_number = session[:phone_number]
    otp_service = OtpService.new(phone_number)

    if otp_service.verify_otp(params[:otp])
      redirect_to '/'
    else
      redirect_to '/'
    end
  end
end
