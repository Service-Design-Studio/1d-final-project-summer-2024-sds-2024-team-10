class CustomerInfoController < ApplicationController
  def update_db
    id = params[:id]
    list_of_updates = ['display_name', 'email', 'work', 'industry']
    list_of_values = [params[:display_name], params[:email], params[:work], params[:industry]]

    updates_hash = Hash[list_of_updates.zip(list_of_values)]

    if UserUpdaterService.update_user(id, updates_hash)
      redirect_to taxres_path, notice: 'Customer info was successfully updated.'
    else
      redirect_to taxres_path, alert: 'Update failed.'
    end
  end
end
