# spec/controllers/docs_upload_controller_spec.rb
require 'rails_helper'

RSpec.describe DocsUploadController, type: :controller do
  it 'exists' do
    expect(DocsUploadController.new).to be_an_instance_of(DocsUploadController)
  end

  it 'inherits from ApplicationController' do
    expect(DocsUploadController < ApplicationController).to be true
  end

  describe 'GET actions' do

    it 'responds to #proof_of_identity' do
      get :proof_of_identity
      expect(response).to be_successful
    end

    it 'responds to #proof_of_residential' do
      get :proof_of_residential
      expect(response).to be_successful
    end

    it 'responds to #proof_of_employment' do
      get :proof_of_employment
      expect(response).to be_successful
    end

    it 'responds to #proof_of_taxres' do
      get :proof_of_taxres
      expect(response).to be_successful
    end

    it 'responds to #proof_of_mobile' do
      get :proof_of_mobile
      expect(response).to be_successful
    end
  end

  describe 'POST actions' do
    it 'responds to #upload_proof_of_identity' do
      post :upload_proof_of_identity
      expect(response).to be_successful
    end

    it 'responds to #upload_proof_of_employment' do
      post :upload_proof_of_employment
      expect(response).to be_successful
    end

    it 'responds to #upload_proof_of_residential' do
      post :upload_proof_of_residential
      expect(response).to be_successful
    end

    it 'responds to #upload_proof_of_taxres' do
      post :upload_proof_of_taxres
      expect(response).to be_successful
    end

    it 'responds to #upload_proof_of_mobile' do
      post :upload_proof_of_mobile
      expect(response).to be_successful
    end
  end
end