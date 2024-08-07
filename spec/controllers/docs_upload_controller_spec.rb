# spec/controllers/docs_upload_controller_spec.rb
require 'rails_helper'

RSpec.describe DocsUploadController, type: :controller do


  describe 'GET #proof_of_identity' do
    it 'renders the proof_of_identity template' do
      get :proof_of_identity
      expect(response).to render_template(:proof_of_identity)
    end
  end

  describe 'GET #proof_of_residential' do
    it 'renders the proof_of_residential template' do
      get :proof_of_residential
      expect(response).to render_template(:proof_of_residential)
    end
  end

  describe 'GET #proof_of_employment' do
    it 'renders the proof_of_employment template' do
      get :proof_of_employment
      expect(response).to render_template(:proof_of_employment)
    end
  end

  describe 'GET #proof_of_taxres' do
    it 'renders the proof_of_taxres template' do
      get :proof_of_taxres
      expect(response).to render_template(:proof_of_taxres)
    end
  end

  describe 'GET #proof_of_mobile' do
    it 'renders the proof_of_mobile template' do
      get :proof_of_mobile
      expect(response).to render_template(:proof_of_mobile)
    end
  end

  describe 'GET #upload_proof_of_identity' do
    it 'renders the upload_proof_of_identity template' do
      get :upload_proof_of_identity
      expect(response).to render_template(:upload_proof_of_identity)
    end
  end

  describe 'GET #upload_proof_of_employment' do
    it 'renders the upload_proof_of_employment template' do
      get :upload_proof_of_employment
      expect(response).to render_template(:upload_proof_of_employment)
    end
  end

  describe 'GET #upload_proof_of_residential' do
    it 'renders the upload_proof_of_residential template' do
      get :upload_proof_of_residential
      expect(response).to render_template(:upload_proof_of_residential)
    end
  end

  describe 'GET #upload_proof_of_taxres' do
    it 'renders the upload_proof_of_taxres template' do
      get :upload_proof_of_taxres
      expect(response).to render_template(:upload_proof_of_taxres)
    end
  end

  describe 'GET #upload_proof_of_mobile' do
    it 'renders the upload_proof_of_mobile template' do
      get :upload_proof_of_mobile
      expect(response).to render_template(:upload_proof_of_mobile)
    end
  end
end
