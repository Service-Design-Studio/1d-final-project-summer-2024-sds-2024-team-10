require 'rails_helper'
require 'spec_helper'
require_relative '../app/services/gemini_service'

RSpec.describe 'GeminiService' do
  describe '.generate_content' do
    let(:image_data) { 'fake_image_data' }
    let(:prompt_text) { 'Describe this scene' }
    let(:base64_image) { Base64.strict_encode64(image_data) }
    let(:api_key) { "AIzaSyBV5Mn_j1U2DMTvK-s2jvmgpbpxlteOhwg" }
    let(:uri_string) { "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=#{api_key}" }

    let(:request_body) do
      {
        contents: [
          {
            parts: [
              { text: prompt_text },
              {
                inlineData: {
                  mimeType: 'image/png',
                  data: base64_image
                }
              }
            ]
          }
        ]
      }.to_json
    end

    let(:response_body) { { 'candidates' => [{ 'content' => { 'parts' => [{ 'text' => 'A sunny day' }] } }] }.to_json }

    before do
      stub_request(:post, uri_string)
        .with(body: request_body, headers: {'Content-Type' => 'application/json'})
        .to_return(status: 200, body: response_body, headers: {})
    end

    it 'sends the correct request and processes the response' do
      response = generate_content(image_data, prompt_text)
      expect(response).to be_a(Hash)
      expect(response['candidates']).to be_an(Array)
      expect(response['candidates'].first['content']['parts'].first['text']).to eq('A sunny day')
    end

    it 'encodes the image data correctly' do
      generate_content(image_data, prompt_text)
      expect(WebMock).to have_requested(:post, uri_string)
                         .with(body: request_body, headers: {'Content-Type' => 'application/json'})
    end
  end
end
