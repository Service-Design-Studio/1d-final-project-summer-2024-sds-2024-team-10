class ChecklistController < ApplicationController
  def checklist
    # Any setup you need for the checklist view
  end

  def show
    @item = params[:item]
    # Logic to display the specific checklist item
    redirect_to checklist_path(@item)
  end

  def submit_checklist
    checked_items = params[:checklist] || {}

    if checked_items.values.all? { |v| v == '1' }
      flash[:notice] = "All items checked! Proceeding to the next step."
      redirect_to upload_path()
    else
      flash[:alert] = "Please check all items before proceeding."
      #redirect_to checklist_path
    end
  end

  def upload
    # Logic for the upload page
  end

  private

  def expected_number_of_items
    5 # Update this number based on the number of checklist items
  end
end