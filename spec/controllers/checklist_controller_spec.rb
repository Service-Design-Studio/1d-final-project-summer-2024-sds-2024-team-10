# spec/controllers/checklist_controller_spec.rb
require 'rails_helper'

RSpec.describe ChecklistController, type: :controller do
  describe 'GET #checklist' do
    before do
      get :checklist
    end

    it 'assigns @checklist_items' do
      expected_checklist_items = {
        passport: ['Proof of Identity',{'Identity Card (For Malaysians)' => "malaysiaic.jpg",'Passport (For other Nationalities)' => 'passport.jpg'}], 
        employment: ['Proof of Employment',{'Employment Letter' => "employment.jpg",'Student Pass' => "studentpass.jpg",'Dependent/Long Term Visit Pass' => "dependantpass.jpg"}], 
        address: ['Proof of Residential Address',{'Singapore utility/telecommunication bill' => "address.jpg",'Certification letter of employment' => "employmentaddress.jpg",'Certification letter from school' => "educationaddress.png"}], 
        tax: ['Proof of Tax Residency',{'Passport' => "passport.jpg",'National Identity Card' => "malaysiaic.jpg",'Student Pass' => "studentpass.jpg"}], 
        mobile: ['Proof of Mobile Ownership',{'Telco Bill' => "mobile.jpg",'Telco Confirmation Letter' => "telcoconfirm.jpg"}] 
      }

      expect(assigns(:checklist_items)).to eq(expected_checklist_items)
    end

    it 'renders the checklist template' do
      expect(response).to render_template(:checklist)
    end
  end

  describe 'GET #next' do
    before do
      get :next
    end

    it 'redirects to /general_info' do
      expect(response).to redirect_to('/general_info')
    end
  end
end
