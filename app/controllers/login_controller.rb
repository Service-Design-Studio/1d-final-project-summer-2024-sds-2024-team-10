class LoginController < ApplicationController
  def login_authentication
    user = User.find_record(display_name: params[:display_name])
    
    if user
      session[:user_id] = user.id
      puts "user found, session[:user_id] set to #{session[:user_id]}"

      correct_password = User.authenticate_password(user, params[:password])
      if !correct_password
        flash[:alert] = 'Wrong credentials, please try again.'
        redirect_to login_path
      else
        if user.application_status == "approved"
          puts "existing customer"
          redirect_to existing_customer_home_path
        else
          puts "new customer"
          flash[:alert] = 'Account Application Incomplete, click Sign Up to complete application'
          redirect_to login_path
        end
      end
    end
  end

  def signup_authentication
    user = User.find_record(phone_number: params[:phone_number])
    phone_number = params[:phone_number]
    full_name = params[:full_name]

    session[:phone_number] = phone_number

    if user      
      if user.full_name == full_name
        session[:user_id] = user.id
        puts "user db record found, session[:user_id] set to #{session[:user_id]}"

        if user.application_status == "approved"
          puts "existing customer, route to login"
          flash[:alert] = 'Account Application Completed, click Log In to proceed'
          redirect_to signup_path
        else
          puts "old application record"
          session[:application_record] = true
          redirect_to generate_otp_path
        end
      else
        puts "recovery_phone_number, new_record"
        session[:recovery_phone_number] = true
        create_new_record
      end
    else
      # "total new user"
      create_new_record
    end
  end

  private

  def create_new_record
    new_user = User.create(user_params)
    if new_user.persisted?
      session[:user_id] = new_user.id
      puts "new user created and authenticated, session[:user_id] set to #{session[:user_id]}"
      redirect_to generate_otp_path
    else
      puts "Failed to create new user"
      flash[:alert] = 'Failed to create new user, please try again later'
      redirect_to signup_path
    end
  end
  
  def user_params
    {
      full_name: params[:full_name],
      phone_number: params[:phone_number],
      password: 'testing',
      application_status: 'pending'
    }
  end
end
