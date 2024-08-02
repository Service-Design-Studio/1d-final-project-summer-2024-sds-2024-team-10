class LoginController < ApplicationController
  def login
    if request.post?
      phone_number = params[:country_code] + params[:phone_number]
      user = User.authenticate(params[:full_name], phone_number, params[:password])
      if user
        session[:user_id] = user.id
        redirect_to create_otp_path
      else
        flash[:alert] = 'Invalid name, phone number, or password'
        render :login
      end
    else
      render :login
    end
  end
end
