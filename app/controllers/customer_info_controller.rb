class CustomerInfoController < ApplicationController
  before_action :set_user, only: [:general_info, :taxres]

  def general_info
    # The @user instance variable will be used in the view to pre-fill the form
  end

  def general_information
  end

  def taxres
    # The @user instance variable will be used in the view to pre-fill the form
  end

  def update_db
    id = params[:user][:id]
    updates_hash = customer_info_params

    # Determine next_path based on the referring URL
    referer = request.referer

    if referer.include?(general_info_path)
      next_path = taxres_path
    elsif referer.include?(taxres_path)
      next_path = proof_of_identity_path
    end

    @user = User.find(id)
    if @user.update(updates_hash)
      redirect_to next_path, notice: 'Customer info was successfully updated.'
    else
      flash[:alert] = 'Update failed.'
      render :general_info
    end
  end

  private

  def set_user
    @user = User.find_by(id: session[:user_id])

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
    params.require(:user).permit(
      :display_name, :email, :work, :industry,
      :tax_resident_country, :tin
    )
  end
end
