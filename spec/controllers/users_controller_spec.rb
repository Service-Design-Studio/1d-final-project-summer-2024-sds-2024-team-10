# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) do
    User.create(
      full_name: "John Doe",
      display_name: "JohnDoe",
      phone_number: "1234567890",
      password: "password",
      dob: "1990-01-01",
      fin: "S1234567F",
      country_of_residence: "USA",
      postal_code: "12345",
      block: "123",
      floor: "4",
      unit: "56",
      address_line_1: "123 Main St",
      address_line_2: "Apt 4",
      work: "Software Engineer",
      industry: "Technology",
      tax_resident_country: "US",
      tin: "123-45-6789",
      gender: "Male",
      email: "john.doe@example.com",
      application_status: "pending",
      identity_type: "Passport",
      passport_number: "A1234567",
      nric_number: "S1234567F",
      nationality: "American",
      passport_expiry_date: "2030-01-01",
      application_date: "2022-01-01",
      proof_of_identity: "proof_of_identity.jpg",
      proof_of_residential_address: "proof_of_address.jpg",
      employment_pass: "employment_pass.jpg",
      proof_of_mobile_phone_ownership: "proof_of_mobile.jpg",
      proof_of_tax_residency: "proof_of_tax.jpg"
    )
  end

  let(:valid_attributes) do
    {
      full_name: "Jane Doe",
      display_name: "JaneDoe",
      phone_number: "0987654321",
      password: "password123",
      dob: "1991-01-01",
      fin: "S9876543F",
      country_of_residence: "Canada",
      postal_code: "54321",
      block: "456",
      floor: "7",
      unit: "89",
      address_line_1: "456 Elm St",
      address_line_2: "Suite 7",
      work: "Data Scientist",
      industry: "Analytics",
      tax_resident_country: "Canada",
      tin: "987-65-4321",
      gender: "Female",
      email: "jane.doe@example.com",
      application_status: "approved",
      identity_type: "National ID",
      passport_number: "B9876543",
      nric_number: "S9876543F",
      nationality: "Canadian",
      passport_expiry_date: "2035-01-01",
      application_date: "2023-01-01",
      proof_of_identity: "proof_of_identity_new.jpg",
      proof_of_residential_address: "proof_of_address_new.jpg",
      employment_pass: "employment_pass_new.jpg",
      proof_of_mobile_phone_ownership: "proof_of_mobile_new.jpg",
      proof_of_tax_residency: "proof_of_tax_new.jpg"
    }
  end

  let(:invalid_attributes) { valid_attributes.merge(full_name: nil) }

  describe 'GET #index' do
    it 'assigns all users to @users' do
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user to @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the show template' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new user to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user to @user' do
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the edit template' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the new user' do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: invalid_attributes }
        }.not_to change(User, :count)
      end

      it 'renders the new template' do
        post :create, params: { user: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the user' do
        patch :update, params: { id: user.id, user: { full_name: "Jane Doe" } }
        user.reload
        expect(user.full_name).to eq("Jane Doe")
      end

      it 'redirects to the updated user' do
        patch :update, params: { id: user.id, user: { full_name: "Jane Doe" } }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the user' do
        patch :update, params: { id: user.id, user: invalid_attributes }
        user.reload
        expect(user.full_name).not_to eq(nil)
      end

      it 'renders the edit template' do
        patch :update, params: { id: user.id, user: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH/PUT #update_db' do
    let(:updates_hash) { { full_name: "Updated Name" } }
    let(:list_of_updates) { updates_hash.keys.map(&:to_s) }

    context 'with valid updates' do
      it 'updates the user' do
        patch :update_db, params: { id: user.id, user: updates_hash, list_of_updates: list_of_updates, next_path: user_path(user) }
        user.reload
        expect(user.full_name).to eq("Updated Name")
      end

      it 'redirects to the next path with a notice' do
        patch :update_db, params: { id: user.id, user: updates_hash, list_of_updates: list_of_updates, next_path: user_path(user) }
        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to eq('User was successfully updated.')
      end
    end

    context 'with invalid updates' do
      it 'does not update the user' do
        allow(UserUpdaterService).to receive(:update_user).and_return(false)
        patch :update_db, params: { id: user.id, user: updates_hash, list_of_updates: list_of_updates, next_path: user_path(user) }
        expect(response).to render_template(:edit)
        expect(flash[:alert]).to eq('Update failed.')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to users#index' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_url)
    end
  end
end