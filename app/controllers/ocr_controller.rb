require_relative '../services/gemini_service'
require 'base64'

class OcrController < ApplicationController
  def process(response)
    image_data = params[:image_data].split(",")[1]
    gemini = GeminiService.new()
    result = gemini.generate_content(Base64.decode64(image_data),"Check if the uploaded image is blurry or not an legitimate phone bill, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the phone number from the phone bill and return it as a separate key-value pair, the key values should be blurry,legitimate and phone_number,fill in empty slots with null. Do not use JSON/python format for the output")
    result = result["candidates"][0]["content"]["parts"][0]["text"].split("\n")[0,3]
    hash = {}
    result.each do |line|
      key, value = line.strip().split(':') 
      puts key,value
      key = key.to_sym
      value = case value
              when 1 , '1' , "True" , "true", ' 1', '1 '
                1
              when 0 , '0' , "False" , "false", ' 0', '0 '
                0
              else
                value
              end
      # Add to the hash
      hash[key] = value
    end
    puts hash
    if hash[:blurry] == 1
      @result = "Image too blurry please retake."
      @enable = false
    elsif hash[:legitimate] == 0
      @result = "Please take an image of your phone bill please."
      @enable = false
    else
      @result = "Phone number: #{hash[:phone_number]}"
      @enable = true
    end
    respond_to do |format|
      format.json { render json: { result: @result ,enable:@enable} }
    end
  end
end
