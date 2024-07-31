# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def switch_language
    session[:locale] = params[:language]
    redirect_to request.referer || root_path
  end
end