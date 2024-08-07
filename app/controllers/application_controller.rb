class ApplicationController < ActionController::Base
  before_action :set_locale

  def change_locale
    session[:locale] = params[:locale]
    Rails.logger.debug "Locale set to: #{session[:locale]}"  # Add this line for debugging
    redirect_to request.referrer || root_path
  end
  

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    Rails.logger.debug "I18n.locale set to: #{I18n.locale}"
  end

  private

  def log_session
    Rails.logger.debug "Session ID: #{session[:user_id]}"
  end
end
