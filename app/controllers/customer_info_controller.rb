class CustomerInfoController < ApplicationController
  def update_db
    id = params[:id]
    updates_hash = customer_info_params.to_h

    # Determine next_path based on the referring URL
    referer = request.referer

    if referer.include?(general_info_path)
      next_path = taxres_path
    elsif referer.include?(taxres_path)
      next_path = proof_of_identity_path
    end
    
    if UserUpdaterService.update_user(id, updates_hash)
      redirect_to next_path, notice: 'Customer info was successfully updated.'
    else
      redirect_to next_path, alert: 'Update failed.'
    end
  end

  private

  def customer_info_params
    params.permit(
      :display_name, :email, :work, :industry, 
      :tax_resident_country, :tin
    )
  end
end
