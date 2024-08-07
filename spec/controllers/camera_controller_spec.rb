require 'rails_helper'

RSpec.describe CameraController, type: :controller do
  let(:service) { instance_double(GeminiService) }

  before do
    allow(GeminiService).to receive(:new).and_return(service)
  end

  shared_examples_for 'a valid camera action' do |action, query, invalid_message|
    let(:params) { { image_data: 'data:image/png;base64,fakebase64image' } }
    let(:result_text) do
      "blurry: 0\nlegitimate: 1\ndocument_type: passport\nNationality: Singapore\npassport_expiry_date: 2030-01-01\nname: John Doe\ngender: Male\ndate_of_birth: 1990-01-01"
    end

    let(:service_response) do
      { "candidates" => [{ "content" => { "parts" => [{ "text" => result_text }] } }] }
    end

    before do
      allow(service).to receive(:generate_content).with(anything, query).and_return(service_response)
    end

    it "returns the expected result for #{action}" do
      post action, params: params, as: :json
      json_response = JSON.parse(response.body)
      result_hash = JSON.parse(json_response['result'].gsub('=>', ':'))
      expect(result_hash['name']).to eq('John Doe')
      expect(json_response['enable']).to eq(true)
    end

    it "returns an error message if the image is blurry for #{action}" do
      allow(service).to receive(:generate_content).and_return({ "candidates" => [{ "content" => { "parts" => [{ "text" => "blurry: 1\nlegitimate: 1" }] } }] })
      post action, params: params, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq('Image too blurry please retake.')
      expect(json_response['enable']).to eq(false)
    end

    it "returns an error message if the document is not legitimate for #{action}" do
      allow(service).to receive(:generate_content).and_return({ "candidates" => [{ "content" => { "parts" => [{ "text" => "blurry: 0\nlegitimate: 0" }] } }] })
      post action, params: params, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(invalid_message)
      expect(json_response['enable']).to eq(false)
    end
  end

  describe 'POST #identity' do
    it_behaves_like 'a valid camera action', :identity, "Check if the uploaded image is blurry or not an legitimate document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the document type, Nationality,  Passport number, passport expiry date, name , gender, date of birth or the equivalent of these values from the  passport and return it as a separate key-value pair, the key values should be blurry,legitimate, document_type, Nationality, passport_expiry_date, name , gender, date_of_birth,fill in empty slots with null. Do not use JSON/python format for the output and all key values should be lowercase", 'Please take an image of your identification document please.'
  end

  describe 'POST #employment' do
    it_behaves_like 'a valid camera action', :employment, "Check if the uploaded image is blurry or not a legitimate employment document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the name and return it as a separate key-value pair. The key values should be blurry, legitimate and name with empty slots filled in with 'null.' Do not use JSON/python format for the output and all key values should be lowercase.", 'Please take an image of your proof of employment please.'
  end

  describe 'POST #address' do
    it_behaves_like 'a valid camera action', :address, "Check if the uploaded image is blurry or not a legitimate document containing residential address, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the name, postal code, floor and unit number or the equivalent of these values from the document and return it as a separate key-value pair. The key values should be blurry, legitimate, name, postal_code, floor and unit_number with empty slots filled in with 'null.' Do not use JSON/python format for the output and all key values should be lowercase.", 'Please take an image of your proof of residential address please.'
  end

  describe 'POST #tax' do
    it_behaves_like 'a valid camera action', :tax, "Check if the uploaded image is blurry or not a legitimate document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the name and the tax residency identification number or the equivalent of these values from the document and return it as a separate key-value pair. The key values should be blurry, legitimate, name and tax_residency with empty slots filled in with 'null.' Do not use JSON/python format for the output and all key values should be lowercase.", 'Please take an image of your proof of tax residency please.'
  end

  describe 'POST #mobile' do
    it_behaves_like 'a valid camera action', :mobile, "Check if the uploaded image is blurry or not a legitimate document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the phone number and name from the document and return it as a separate key-value pair. The key values should be blurry, legitimate, name and mobile with empty slots filled in with 'null.' Do not use JSON/python format for the output and all key values should be lowercase.", 'Please take an image of your proof of mobile phone number please.'
  end
end
