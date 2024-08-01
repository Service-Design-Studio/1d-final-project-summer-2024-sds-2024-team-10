# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_locale

  def switch_language
    session[:locale] = params[:language]
    redirect_to request.referrer || root_path
  end

  private

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end
end
