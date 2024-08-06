class DocsUploadController < ApplicationController
  def upload
  end

  def proof_of_identity
  end

  def proof_of_residential
  end
  
  def proof_of_employment
  end

  def proof_of_taxres
  end
  
  def proof_of_mobile
  end

  def upload_proof_of_identity
  end

  def upload_proof_of_employment
  end

  def upload_proof_of_residential
  end

  def upload_proof_of_taxres
    if !session[:recovery_phone_number]
      redirect_to summary_page_path
    end
  end

  def upload_proof_of_mobile
  end
end
