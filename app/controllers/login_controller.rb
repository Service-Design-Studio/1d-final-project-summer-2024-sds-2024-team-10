class LoginController < ApplicationController
  def login_authentication
    phone_number = params[:phone_number]
    user = User.authenticate(params[:full_name], phone_number, params[:password])

    if user
      session[:user_id] = user.id
      session[:phone_number] = params[:phone_number]
      puts "user authenticated, session[:user_id] set to #{session[:user_id]}"
      if user.application_status == "approved"
        puts "existing customer"
        redirect_to existing_customer_home_path
      else
        puts "new customer"
        redirect_to generate_otp_path
      end
    else
      puts "cant find user in db, creating new user"
      new_user = User.create(user_params)
      if new_user.persisted?
        session[:user_id] = new_user.id
        session[:phone_number] = params[:phone_number]
        puts "new user created and authenticated, session[:user_id] set to #{session[:user_id]}"
        redirect_to generate_otp_path
      else
        puts "Failed to create new user"
        flash[:alert] = 'Failed to create new user'
        render :login
      end
    end
  end

  private

  def user_params
    {
      full_name: params[:full_name],
      phone_number: params[:phone_number],
      password: params[:password],
      application_status: 'pending'
    }
  end
end
