class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update,  :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # def update_db
  #   updates_hash = user_params.to_h.slice(*params[:list_of_updates])
  #   if UserUpdaterService.update_user(@user.id, updates_hash)
  #     redirect_to params[:next_path], notice: 'User was successfully updated.'
  #   else
  #     render :edit, alert: 'Update failed.'
  #   end
  # end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Item was successfully updated.'
      puts 'db updated'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:full_name, :display_name, :phone_number, :password, :dob, :fin, :country_of_residence, :postal_code, :block, :floor, :unit, :address_line_1, :address_line_2, :work, :industry, :tax_resident_country, :tin, :gender, :email, :application_status, :identity_type, :passport_number, :nric_number, :nationality, :passport_expiry_date, :application_date, :proof_of_identity, :proof_of_residential_address, :employment_pass, :proof_of_mobile_phone_ownership, :proof_of_tax_residency)
  end
end
