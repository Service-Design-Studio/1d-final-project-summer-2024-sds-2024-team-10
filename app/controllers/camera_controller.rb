require_relative '../services/gemini_service'
require 'base64'
class CameraController < ApplicationController
  def identification
    image_data = params[:image_data].split(",")[1]
    result = generate_content(Base64.decode64(image_data),"Check if the uploaded image is blurry or not an legitimate document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the document type, Nationality,  Passport number, passport expiry date, name , gender, date of birth or the equivalent of these values from the  passport and return it as a separate key-value pair, the key values should be blurry,legitimate, document type, Nationality, passport expiry date, name , gender, date of birth,fill in empty slots with null. Do not use JSON/python format for the output")
    result = result["candidates"][0]["content"]["parts"][0]["text"].split("\n")[0,8]
    hash = {}
    result.each do |line|
      key, value = line.strip().split(':') 
      key = key.to_sym
      value = case value
              when 1 , '1' , "True" , "true", ' 1', '1 '
                1
              when 0 , '0' , "False" , "false", ' 1', '1 '
                0
              else
                value
              end
      # Add to the hash
      hash[key] = value
    end
    if hash[:blurry] == 1
      @result = "Image too blurry please retake."
      @enable = false
    elsif hash[:legitimate] == 0
      @result = "Please take an image of your phone bill please."
      @enable = false
    else
      @result = "Phone number: #{hash[:legitimate]}"
      @enable = true
    end
    respond_to do |format|
      format.json { render json: { result: @result ,enable:@enable} }
    end
  end

  def mobile
    image_data = params[:image_data].split(",")[1]
    result = generate_content(Base64.decode64(image_data),"Check if the uploaded image is blurry or not an legitimate document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the document type, Nationality,  Passport number, passport expiry date, name , gender, date of birth or the equivalent of these values from the  passport and return it as a separate key-value pair, the key values should be blurry,legitimate, document_type, Nationality, passport_expiry_date, name , gender, date_of_birth,fill in empty slots with null. Do not use JSON/python format for the output")
    result = result["candidates"][0]["content"]["parts"][0]["text"].split("\n")[0,7]
    hash = {}
    result.each do |line|
      key, value = line.strip().split(':') 
      puts key,value
      key = key.to_sym
      value = case value
              when 1 , '1' , "True" , "true", ' 1', '1 '
                1
              when 0 , '0' , "False" , "false", ' 1', '1 '
                0
              else
                value
              end
      # Add to the hash
      hash[key] = value
    end
    puts hash
    # if hash[:blurry] == 1
    #   @result = "Image too blurry please retake."
    #   @enable = false
    # elsif hash[:legitimate] == 0
    #   @result = "Please take an image of your phone bill please."
    #   @enable = false
    # else
    #   @result = "Phone number: #{hash[:phone_number]}"
    #   @enable = true
    # end
    # respond_to do |format|
    #   format.json { render json: { result: @result ,enable:@enable} }
    # end
  end
end  

  # def process(response)
  #   image_data = params[:image_data].split(",")[1]
  #   result = generate_content(Base64.decode64(image_data),"Check if the uploaded image is blurry or not an legitimate document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the document type, Nationality,  Passport number, passport expiry date, name , gender, date of birth or the equivalent of these values from the  passport and return it as a separate key-value pair, the key values should be blurry,legitimate, document type, Nationality, passport expiry date, name , gender, date of birth,fill in empty slots with null. Do not use JSON/python format for the output")
  #   # puts result
  #   result = result["candidates"][0]["content"]["parts"][0]["text"].split("\n")
  #   result = result[:result.length]
  #   puts result
  #   hash = {}
  #   result.each do |line|
  #     key, value = line.strip().split(':') 
  #     puts key,value
  #     key = key.to_sym
  #     value = case value
  #             when 1 , '1' , "True" , "true", ' 1', '1 '
  #               1
  #             when 0 , '0' , "False" , "false", ' 1', '1 '
  #               0
  #             else
  #               value
  #             end
  #     # Add to the hash
  #     hash[key] = value
  #   end
  #   puts hash
  #   # if hash[:blurry] == 1
  #   #   @result = "Image too blurry please retake."
  #   #   @enable = false
  #   # elsif hash[:legitimate] == 0
  #   #   @result = "Please take an image of your phone bill please."
  #   #   @enable = false
  #   # else
  #   #   @result = "Phone number: #{hash[:phone_number]}"
  #   #   @enable = true
  #   # end
  #   # respond_to do |format|
  #   #   format.json { render json: { result: @result ,enable:@enable} }
  #   # end
  # end

  # def process(response)
  #   image_data = params[:image_data].split(",")[1]
  #   result = generate_content(Base64.decode64(image_data),"Check if the uploaded image is blurry or not an legitimate document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the document type, Nationality,  Passport number, passport expiry date, name , gender, date of birth or the equivalent of these values from the  passport and return it as a separate key-value pair, the key values should be blurry,legitimate, document type, Nationality, passport expiry date, name , gender, date of birth,fill in empty slots with null. Do not use JSON/python format for the output")
  #   puts result
  #   result = result["candidates"][0]["content"]["parts"][0]["text"].split("\n")[0,3]
  #   hash = {}
  #   result.each do |line|
  #     key, value = line.strip().split(':') 
  #     puts key,value
  #     key = key.to_sym
  #     value = case value
  #             when 1 , '1' , "True" , "true", ' 1', '1 '
  #               1
  #             when 0 , '0' , "False" , "false", ' 1', '1 '
  #               0
  #             else
  #               value
  #             end
  #     # Add to the hash
  #     hash[key] = value
  #   end
  #   puts hash
  #   # if hash[:blurry] == 1
  #   #   @result = "Image too blurry please retake."
  #   #   @enable = false
  #   # elsif hash[:legitimate] == 0
  #   #   @result = "Please take an image of your phone bill please."
  #   #   @enable = false
  #   # else
  #   #   @result = "Phone number: #{hash[:phone_number]}"
  #   #   @enable = true
  #   # end
  #   # respond_to do |format|
  #   #   format.json { render json: { result: @result ,enable:@enable} }
  #   # end
  # end

  # def process(response)
  #   image_data = params[:image_data].split(",")[1]
  #   result = generate_content(Base64.decode64(image_data),"Check if the uploaded image is blurry or not an legitimate document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the document type, Nationality,  Passport number, passport expiry date, name , gender, date of birth or the equivalent of these values from the  passport and return it as a separate key-value pair, the key values should be blurry,legitimate, document type, Nationality, passport expiry date, name , gender, date of birth,fill in empty slots with null. Do not use JSON/python format for the output")
  #   puts result
  #   result = result["candidates"][0]["content"]["parts"][0]["text"].split("\n")[0,7]
  #   hash = {}
  #   result.each do |line|
  #     key, value = line.strip().split(':') 
  #     puts key,value
  #     key = key.to_sym
  #     value = case value
  #             when 1 , '1' , "True" , "true", ' 1', '1 '
  #               1
  #             when 0 , '0' , "False" , "false", ' 1', '1 '
  #               0
  #             else
  #               value
  #             end
  #     # Add to the hash
  #     hash[key] = value
  #   end
  #   puts hash
  #   # if hash[:blurry] == 1
  #   #   @result = "Image too blurry please retake."
  #   #   @enable = false
  #   # elsif hash[:legitimate] == 0
  #   #   @result = "Please take an image of your phone bill please."
  #   #   @enable = false
  #   # else
  #   #   @result = "Phone number: #{hash[:phone_number]}"
  #   #   @enable = true
  #   # end
  #   # respond_to do |format|
  #   #   format.json { render json: { result: @result ,enable:@enable} }
  #   # end
  # end
# end