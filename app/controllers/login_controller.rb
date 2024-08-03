class LoginController < ApplicationController
  def login
    if request.post?
      phone_number = params[:phone_number]
      user = User.authenticate(params[:full_name], phone_number, params[:password])

      if user
        session[:user_id] = user.id
        session[:phone_number] = params[:phone_number]
        puts "user authenticated"
        if user.application_status == "approved"
          redirect_to existing_customer_home_path
          puts "existing customer"
        else
          puts "new customer"
          redirect_to generate_otp_path
        end
      else
        puts "cant find user in db"
        flash[:alert] = 'Invalid name, phone number, or password'
        render :login
      end
    else
      render :login
    end
  end
end
