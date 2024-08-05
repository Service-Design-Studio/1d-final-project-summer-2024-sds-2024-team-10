# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_locale

  def switch_language
    session[:locale] = params[:language]
    redirect_to request.referrer || root_path
  end

  def change_locale
    session[:locale] = params[:locale] if params[:locale].present?
    redirect_to request.referer || root_path, notice: t('language_changed')
  end


  private

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def log_session
    Rails.logger.debug "Session ID: #{session[:user_id]}"
  end
end
