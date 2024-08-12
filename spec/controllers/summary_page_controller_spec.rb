# spec/controllers/summary_page_controller_spec.rb
require 'rails_helper'

RSpec.describe SummaryPageController, type: :controller do
  let!(:user) do
    User.create(
      full_name: "John Doe Pink",
      display_name: "John Doe",
      password: "123456",
      dob: "1990-01-01",
      gender: "Male",
      nationality: "American",
      email: "john.doe@example.com",
      phone_number: "1234567890",
      passport_number: "A1234567",
      fin: "S1234567F",
      passport_expiry_date: "2030-01-01",
      country_of_residence: "USA",
      block: "123",
      floor: "4",
      unit: "56",
      address_line_1: "123 Main St",
      address_line_2: "Apt 4",
      postal_code: "12345",
      work: "Software Engineer",
      industry: "Technology",
      tax_resident_country: "US",
      tin: "123-45-6789"
    )
  end

  describe 'GET #summary_page' do
    context 'when user is logged in' do
      before do
        session[:user_id] = user.id
        get :summary_page
      end

      it 'assigns the requested user to @user' do
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the summary_page template' do
        expect(response).to render_template(:summary_page)
      end
    end

    context 'when user is not logged in' do
      before do
        session[:user_id] = nil
        get :summary_page
      end

      it 'does not assign a user to @user' do
        expect(assigns(:user)).to be_nil
      end

      it 'logs a message about missing session id' do
        expect { get :summary_page }.to output(/Session ID is nil/).to_stdout
      end
    end
  end

  describe 'POST #update_db' do
    context 'with valid attributes' do
      before do
        session[:user_id] = user.id
        post :update_db, params: { user: { id: user.id, full_name: 'Jane Doe' } }
      end

      it 'updates the user' do
        user.reload
        expect(user.full_name).to eq('Jane Doe')
      end

      it 'redirects to the end_of_application path' do
        expect(response).to redirect_to(end_of_application_path)
      end

      it 'logs a success message' do
        expect { post :update_db, params: { user: { id: user.id, full_name: 'Jane Doe' } } }.to output(/Customer info was successfully updated/).to_stdout
      end
    end

  
  end
end