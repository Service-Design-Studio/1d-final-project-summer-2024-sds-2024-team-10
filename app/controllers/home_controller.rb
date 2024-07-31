class HomeController < ApplicationController
  def index
    @message = "SDS Team 10: DBS_DocCheck"
    @greeting = case I18n.locale
    when :es
      "¡Hola Mundo!"
    when :"zh-TW"
      "你好，世界！"
    when :ta
      "வணக்கம் உலகம்!"
    else
      "Hello World!"
    end
  end

  def switch_language
    if params[:language] == 'zh'
      redirect_to signup_chi_path
    elsif params[:language] == 'ta'
      redirect_to signup_ta_path
    else
      redirect_to signup_path
    end
  end

  def about
  end

  def contact
  end

  def new
  end

  def signup
  end

  def address
    redirect_to '/address'
  end

  def work
  end

  def industry
  end

  def taxres
  end

  def application
  end

  def reload_application_draft
    reload = true
    redirect_to address_path
  end
end
