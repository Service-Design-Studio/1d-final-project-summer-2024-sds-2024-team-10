require_relative '../services/gemini_service'
require 'base64'
class CameraController < ApplicationController

  def identity_update_db
    user_id = params[:id]
    updates_hash = {
      identity_type: params[:document_type],
      nationality: params[:nationality],
      passport_expiry_date: params[:passport_expiry_date],
      full_name: params[:name],
      gender: params[:gender],
      dob: params[:date_of_birth]
    }

    @user = User.find(user_id)
    if @user.update(updates_hash)
      puts "Customer info was successfully updated"
      redirect_to proof_of_employment_path
    else
      puts "Update failed"
      render :proof_of_identity
    end
  end

  def employment_update_db
    # user_id = params[:id]
    # updates_hash = {
    #   full_name: params[:name],
    # }
    redirect_to proof_of_residential_path
    # @user = User.find(user_id)
    # if @user.update(updates_hash)
    #   puts "Customer info was successfully updated"
    #   redirect_to proof_of_residential_path
    # else
    #   puts "Update failed"
    #   render :proof_of_employment
    # end
  end
  
  def residential_update_db
    user_id = params[:id]
    updates_hash = {
      full_name: params[:name],
    }

    @user = User.find(user_id)
    if @user.update(updates_hash)
      puts "Customer info was successfully updated"
      redirect_to proof_of_residential_path
    else
      puts "Update failed"
      render :proof_of_mobile
    end
  end
  
  def identity
    image_data = params[:image_data].split(",")[1]

    # Save the image_data to the Document table via DocumentsController
    documents_controller = DocumentsController.new
    response = documents_controller.save_image_data(session[:user_id], 1, "proof_of_identity", "testing")

    service = GeminiService.new
    result = service.generate_content(Base64.decode64(image_data),"Check if the uploaded image is blurry or not an legitimate document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the document type, Nationality,  Passport number, passport expiry date, name , gender, date of birth or the equivalent of these values from the  passport and return it as a separate key-value pair, the key values should be blurry,legitimate, document_type, Nationality, passport_expiry_date, name , gender, date_of_birth,fill in empty slots with null. Do not use JSON/python format for the output and all key values should be lowercase")
    result = result["candidates"][0]["content"]["parts"][0]["text"].split("\n")
    result = result[0,result.length]
    hash = {}
    result.each do |line|
      key, value = line.strip.split(':') 
      value = case value
              when 1 , '1' , "True" , "true", ' 1', '1 '
                1
              when 0 , '0' , "False" , "false", ' 0', '0 '
                0
              else
                value.strip
              end
      # Add to the hash
      hash[key] = value
    end
    puts hash
    if hash["blurry"] == 1
      @result = "Image too blurry please retake."
      @enable = false
    elsif hash["legitimate"] == 0
      @result = "Please take an image of your identification document please."
      @enable = false
    else
      @result = "#{hash}"
      @enable = true
    end
    respond_to do |format|
      format.json { render json: { result: @result ,enable:@enable} }
    end
  end

  def employment
    image_data = params["image_data"].split(",")[1]

    # Save the image_data to the Document table via DocumentsController
    documents_controller = DocumentsController.new
    response = documents_controller.save_image_data(session[:user_id], 2, "proof_of_employment", "testing2")

    service = GeminiService.new
    result = service.generate_content(Base64.decode64(image_data),"Check if the uploaded image is blurry or not a legitimate employment document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the name and return it as a separate key-value pair. The key values should be blurry, legitimate and name with empty slots filled in with 'null.' Do not use JSON/python format for the output and all key values should be lowercase.")
    result = result["candidates"][0]["content"]["parts"][0]["text"].split("\n")
    result = result[0,result.length]
    hash = {}
    puts hash
    result.each do |line|
      key, value = line.strip.split(':') 
      value = case value
              when 1 , '1' , "True" , "true", ' 1', '1 '
                1
              when 0 , '0' , "False" , "false", ' 0', '0 '
                0
              else
                value.strip
              end
      # Add to the hash
      hash[key] = value
    end
    puts hash
    if hash["blurry"] == 1
      @result = "Image too blurry please retake."
      @enable = false
    elsif hash["legitimate"] == 0
      @result = "Please take an image of your proof of employment please."
      @enable = false
    else
      @result = "#{hash}"
      @enable = true
    end
    respond_to do |format|
      format.json { render json: { result: @result ,enable:@enable} }
    end
  end

  def address
    image_data = params[:image_data].split(",")[1]
    service = GeminiService.new
    result = service.generate_content(Base64.decode64(image_data),"Check if the uploaded image is blurry or not a legitimate document containing residential address, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the name, postal code, floor and unit number or the equivalent of these values from the document and return it as a separate key-value pair. The key values should be blurry, legitimate, name, postal_code, floor and unit_number with empty slots filled in with 'null.' Do not use JSON/python format for the output and all key values should be lowercase.")
    result = result["candidates"][0]["content"]["parts"][0]["text"].split("\n")
    result = result[0,result.length]
    hash = {}
    result.each do |line|
      key, value = line.strip.split(':') 
      value = case value
              when 1 , '1' , "True" , "true", ' 1', '1 '
                1
              when 0 , '0' , "False" , "false", ' 0', '0 '
                0
              else
                value.strip
              end
      # Add to the hash
      hash[key] = value
    end
    puts hash
    if hash["blurry"] == 1
      @result = "Image too blurry please retake."
      @enable = false
    elsif hash["legitimate"] == 0
      @result = "Please take an image of your proof of residential address please."
      @enable = false
    else
      @result = "#{hash}"
      @enable = true
    end
    respond_to do |format|
      format.json { render json: { result: @result ,enable:@enable} }
    end
  end

  def tax
    image_data = params[:image_data].split(",")[1]
    service = GeminiService.new
    result = service.generate_content(Base64.decode64(image_data),"Check if the uploaded image is blurry or not a legitimate document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the name and the tax residency identification number or the equivalent of these values from the document and return it as a separate key-value pair. The key values should be blurry, legitimate, name and tax_residency with empty slots filled in with 'null.' Do not use JSON/python format for the output and all key values should be lowercase.")
    result = result["candidates"][0]["content"]["parts"][0]["text"].split("\n")
    result = result[0,result.length]
    hash = {}
    result.each do |line|
      key, value = line.strip.split(':') 
      value = case value
              when 1 , '1' , "True" , "true", ' 1', '1 '
                1
              when 0 , '0' , "False" , "false", ' 0', '0 '
                0
              else
                value.strip
              end
      # Add to the hash
      hash[key] = value
    end
    puts hash
    if hash["blurry"] == 1
      @result = "Image too blurry please retake."
      @enable = false
    elsif hash["legitimate"] == 0
      @result = "Please take an image of your proof of tax residency please."
      @enable = false
    else
      @result = "#{hash}"
      @enable = true
    end
    respond_to do |format|
      format.json { render json: { result: @result ,enable:@enable} }
    end
  end

  def mobile
    image_data = params[:image_data].split(",")[1]
    service = GeminiService.new
    result = service.generate_content(Base64.decode64(image_data),"Check if the uploaded image is blurry or not a legitimate document, and provide the results as boolean integer key-value pairs for both conditions. Additionally, extract the phone number and name from the document and return it as a separate key-value pair. The key values should be blurry, legitimate, name and mobile with empty slots filled in with 'null.' Do not use JSON/python format for the output and all key values should be lowercase.")
    puts result
    result = result["candidates"][0]["content"]["parts"][0]["text"].split("\n")
    result = result[0,result.length]
    hash = {}
    result.each do |line|
      key, value = line.strip.split(':') 
      value = case value
              when 1 , '1' , "True" , "true", ' 1', '1 '
                1
              when 0 , '0' , "False" , "false", ' 0', '0 '
                0
              else
                value.strip
              end
      # Add to the hash
      hash[key] = value
    end
    puts hash
    if hash["blurry"] == 1
      @result = "Image too blurry please retake."
      @enable = false
    elsif hash["legitimate"] == 0
      @result = "Please take an image of your proof of mobile phone number please."
      @enable = false
    else
      @result = "#{hash}"
      @enable = true
    end
    respond_to do |format|
      format.json { render json: { result: @result ,enable:@enable} }
    end
  end

  # def customer_info_params
  #   params.require(:user).permit(
  #     :identity_type, :nationality, :passport_number, :nationality, :passport_expiry_date,
  #     :gender, :dob
  #   )
  # end
end