# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_locale

  def switch_language
    I18n.locale = params[:language] || I18n.default_locale
    session[:locale] = I18n.locale
    redirect_back(fallback_location: root_path)
  end

  private

  def set_locale
    I18n.locale = if I18n.available_locales.map(&:to_s).include?(params[:language])
                    params[:language]
                  else
                    I18n.default_locale
                  end
                end
end
