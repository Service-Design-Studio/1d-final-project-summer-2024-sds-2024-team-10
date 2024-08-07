class OtpController < ApplicationController
  def create
    phone_number = session[:phone_number]
    puts phone_number
    otp_service = OtpService.new(phone_number)
    
    if otp_service.send_otp
      puts "OTP generated"
      redirect_to otp_verification_path
    else
      flash[:alert] = otp_service.error_message
      redirect_to signup_path
    end
  rescue ArgumentError => e
    flash[:alert] = e.message
    redirect_to signup_path
  end

  def verify_otp
    phone_number = session[:phone_number]
    otp_service = OtpService.new(phone_number)

    if otp_service.verify_otp(params[:otp])
      puts "OTP verified"
      redirect_to singpass_path
    else
      flash[:alert] = "OTP verification failed"
      redirect_to otp_verification_path
    end
  end
end
