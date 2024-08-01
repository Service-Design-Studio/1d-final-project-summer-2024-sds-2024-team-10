# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def switch_language
    # This checks if the passed language is among the available ones and sets it; otherwise, it sets the default locale.
    I18n.locale = if I18n.available_locales.map(&:to_s).include?(params[:language])
                    params[:language]
                  else
                    I18n.default_locale
                  end
    session[:locale] = I18n.locale
    redirect_back(fallback_location: root_path)
  end
end
