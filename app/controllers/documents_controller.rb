# app/controllers/documents_controller.rb
class DocumentsController < ApplicationController
  before_action :set_user, only: [:index, :create, :update, :save_image_data]
  before_action :set_document, only: [:update, :save_image_data]

  def index
    @documents = @user.documents
  end

  def create
    @document = @user.documents.new(document_params)

    if @document.save
      render json: @document, status: :created
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  def update
    if @document.update(document_params)
      render json: @document
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  def save_image_data(user_id, document_id, document_name, image_data)
    user = User.find_by(id: user_id)
    puts user_id

    document = document_id ? user.documents.find_by(id: document_id) : user.documents.new
    unless document
      puts "new doc"
      document = user.documents.new
    end
    
    if document.respond_to?(document_name)
      document.send("#{document_name}=", image_data)
    else
      puts "uploaded"
      return { status: :unprocessable_entity, errors: "Invalid document attribute" }
    end

    if document.save
      puts "ok"
    else
      puts "not ok"
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    unless @user
      flash[:alert] = "User not found"
      redirect_to root_path
    end
  end

  def set_document
    @document = @user.documents.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:proof_of_identity, :proof_of_residential_address, :employment_pass, :proof_of_mobile_phone_ownership, :proof_of_tax_residency)
  end
end
