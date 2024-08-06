# spec/controllers/camera_controller_spec.rb
require 'rails_helper'
require_relative '../../app/services/gemini_service'
require 'base64'

RSpec.describe CameraController, type: :controller do
  let!(:user) do
    User.create(
      full_name: "John Doe Pink",
      display_name: "John Doe",
      password: "123456",
      email: "john.doe@example.com",
      work: "Software Engineer",
      industry: "Technology",
      tax_resident_country: "US",
      tin: "123-45-6789"
    )
  end

  let(:image_data) { "data:image/png;base64,#{Base64.encode64('fake_image_data')}" }
  let(:decoded_image_data) { 'fake_image_data' }
  let(:mock_response) do
    {
      'candidates' => [
        {
          'content' => {
            'parts' => [
              {
                'text' => "blurry: 0\nlegitimate: 1\ndocument type: passport\nNationality: Singapore\npassport_expiry_date: 2030-01-01\nname: John Doe\ngender: Male\ndate_of_birth: 1990-01-01"
              }
            ]
          }
        }
      ]
    }
  end

  before do
    allow_any_instance_of(GeminiService).to receive(:generate_content).and_return(mock_response)
  end

  describe 'POST #identity' do
    it 'returns the expected result for identity' do
      post :identity, params: { image_data: image_data }, format: :json
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to include('name: John Doe')
      expect(json_response['enable']).to be true
    end
  end

  describe 'POST #employment' do
    it 'returns the expected result for employment' do
      post :employment, params: { image_data: image_data }, format: :json
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to include('name: John Doe')
      expect(json_response['enable']).to be true
    end
  end

  describe 'POST #address' do
    it 'returns the expected result for address' do
      post :address, params: { image_data: image_data }, format: :json
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to include('name: John Doe')
      expect(json_response['enable']).to be true
    end
  end

  describe 'POST #tax' do
    it 'returns the expected result for tax' do
      post :tax, params: { image_data: image_data }, format: :json
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to include('name: John Doe')
      expect(json_response['enable']).to be true
    end
  end

  describe 'POST #mobile' do
    it 'returns the expected result for mobile' do
      post :mobile, params: { image_data: image_data }, format: :json
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to include('name: John Doe')
      expect(json_response['enable']).to be true
    end
  end
end
