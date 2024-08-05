class LoginController < ApplicationController
  def login_authentication
    user = User.find_record(params[:display_name])
    
    if user
      session[:user_id] = user.id
      puts "user found, session[:user_id] set to #{session[:user_id]}"

      correct_password = User.authenticate_password(user, params[:password])
      if !correct_password
        puts "controller: User pw incorrect"
        flash[:alert] = 'Wrong credentials, please try again.'
        redirect_to login_path
      else
        puts "controller: user pw correct"
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
    user = User.authenticate(params[:full_name], params[:phone_number])

    if user
      session[:user_id] = user.id
      session[:phone_number] = params[:phone_number]
      puts "user authenticated, session[:user_id] set to #{session[:user_id]}"
      if user.application_status == "approved"
        puts "existing customer"
        redirect_to login_path
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
