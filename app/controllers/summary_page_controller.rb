class SummaryPageController < ApplicationController
  before_action :set_user, only: [:summary_page]

  def summary_page
    # The @user instance variable will be used in the view to pre-fill the form
  end

  def update_db
    id = params[:user][:id]

    updates_hash = customer_info_params

    @user = User.find(id)
    if @user.update(updates_hash)
      puts "Customer info was successfully updated"
      redirect_to end_of_application_path
    else
      puts "Update failed"
      render :general_info
    end
  end
  
  private

  def set_user
    @user = User.find_by(id: session[:user_id])
    puts "user db record found, session[:user_id] set to #{session[:user_id]}"
    
    if session[:user_id].nil?
      puts "Session ID is nil"
    else
      puts "Session ID: #{session[:user_id]}"
    end

    if @user.nil?
      puts "User not found with ID: #{session[:user_id]}"
    else
      puts "User found: #{@user.inspect}"
    end
  end

  def customer_info_params
    params.require(:user).permit(:full_name, :display_name, :password, :dob, :gender, :nationality, :email, :phone_number, 
                                 :passport_number, :fin, :passport_expiry_date, :country_of_residence, :block, :floor, 
                                 :unit, :address_line_1, :address_line_2, :postal_code, :work, :industry, 
                                 :tax_resident_country, :tin)
    end
end
