# spec/controllers/application_controller_spec.rb
require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  # Define a dummy controller to handle the routes
  controller do
    def index
      render plain: 'Hello World'
    end

    def switch_language
      super
    end

    def change_locale
      super
    end

    def log_session
      super
      render plain: 'Check log for session'
    end
  end

  before do
    routes.draw do
      get 'index' => 'anonymous#index'
      post 'switch_language' => 'anonymous#switch_language'
      get 'change_locale' => 'anonymous#change_locale'
      get 'log_session' => 'anonymous#log_session'
    end

    # Add necessary locales for testing
    I18n.available_locales = [:en, :es, :fr, :de, :it, :ja, :ru]
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response.body).to eq('Hello World')
    end
  end

  describe 'POST #switch_language' do
    it 'sets the session locale and redirects back' do
      request.env['HTTP_REFERER'] = root_path
      post :switch_language, params: { language: 'es' }
      expect(session[:locale]).to eq('es')
      expect(response).to redirect_to(root_path)
    end

    it 'sets the session locale and redirects to root if referrer is not present' do
      post :switch_language, params: { language: 'fr' }
      expect(session[:locale]).to eq('fr')
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #change_locale' do
    it 'changes the locale and redirects back with a notice' do
      request.env['HTTP_REFERER'] = root_path
      get :change_locale, params: { locale: 'de' }
      expect(I18n.locale).to eq(:de)
      expect(session[:locale]).to eq(:de)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq(I18n.t('language_changed'))
    end

    it 'changes the locale and redirects to root if referrer is not present' do
      get :change_locale, params: { locale: 'it' }
      expect(I18n.locale).to eq(:it)
      expect(session[:locale]).to eq(:it)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq(I18n.t('language_changed'))
    end
  end

  describe 'before_action #set_locale' do
    controller do
      def index
        render plain: I18n.locale
      end
    end

    it 'sets the locale from params' do
      get :index, params: { locale: 'ja' }
      expect(I18n.locale).to eq(:ja)
    end

    it 'sets the locale from session if params is not present' do
      session[:locale] = 'ru'
      get :index
      expect(I18n.locale).to eq(:ru)
    end

    it 'sets the default locale if params and session are not present' do
      get :index
      expect(I18n.locale).to eq(I18n.default_locale)
    end
  end

  describe 'private #log_session' do
    it 'logs the session ID' do
      session[:user_id] = 1
      expect(Rails.logger).to receive(:debug).with("Session ID: 1").and_call_original
      get :index # Trigger an action to call the log_session
    end
  end
end
