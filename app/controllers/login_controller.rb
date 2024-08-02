class LoginController < ApplicationController
  def login
    if request.post?
      phone_number = params[:country_code] + params[:phone_number]
      user = User.authenticate(params[:name], phone_number, params[:password])
      if user
        session[:user_id] = user.id
        redirect_to otp_verification_path
      else
        flash[:alert] = 'Invalid name, phone number, or password'
        render :login
      end
    else
      render :login
    end
  end
end
