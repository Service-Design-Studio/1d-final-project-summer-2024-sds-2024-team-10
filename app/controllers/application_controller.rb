# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_locale

  # def set_locale
  #   I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
  #   session[:locale] = I18n.locale # Persist locale in session
  # end
  
  # def change_locale
  #   redirect_to request.referer || root_path(locale: params[:locale]), notice: t('language_changed')
  # end

  def change_locale
    redirect_to request.referer || root_path, notice: t('language_changed')
  end

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  private



  def log_session
    Rails.logger.debug "Session ID: #{session[:user_id]}"
  end
end
