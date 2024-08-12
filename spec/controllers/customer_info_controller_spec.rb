# spec/controllers/customer_info_controller_spec.rb
require 'rails_helper'

RSpec.describe CustomerInfoController, type: :controller do
  let!(:user) do
    User.create(
      full_name: "John Doe Pink",
      display_name: "John Doe",
      password: "123456",
      email: "john.doe@example.com",
      work: "Software Engineer",
      industry: "Technology",
      tax_resident_country: "US",
      tin: "123-45-6789"
    )
  end

  describe 'GET #general_info' do
    context 'when user is logged in' do
      before do
        session[:user_id] = user.id
        get :general_info
      end

      it 'assigns the requested user to @user' do
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the general_info template' do
        expect(response).to render_template(:general_info)
      end
    end

    context 'when user is not logged in' do
      before do
        session[:user_id] = nil
        get :general_info
      end

      it 'does not assign a user to @user' do
        expect(assigns(:user)).to be_nil
      end

      it 'logs a message about missing session id' do
        expect { get :general_info }.to output(/Session ID is nil/).to_stdout
      end
    end
  end

  describe 'GET #taxres' do
    context 'when user is logged in' do
      before do
        session[:user_id] = user.id
        get :taxres
      end

      it 'assigns the requested user to @user' do
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the taxres template' do
        expect(response).to render_template(:taxres)
      end
    end
  end

  describe 'POST #update_db' do
    context 'with valid attributes from general_info_path' do
      before do
        session[:user_id] = user.id
        request.env['HTTP_REFERER'] = general_info_path
        post :update_db, params: { user: { id: user.id, display_name: 'Jane Doe' } }
      end

      it 'updates the user' do
        user.reload
        expect(user.display_name).to eq('Jane Doe')
      end

      it 'redirects to the next path' do
        expect(response).to redirect_to(taxres_path)
      end

      it 'sets a success notice' do
        expect(flash[:notice]).to eq('Customer info was successfully updated.')
      end
    end

    context 'with valid attributes from taxres_path' do
      before do
        session[:user_id] = user.id
        request.env['HTTP_REFERER'] = taxres_path
        post :update_db, params: { user: { id: user.id, display_name: 'Jane Doe' } }
      end

      it 'updates the user' do
        user.reload
        expect(user.display_name).to eq('Jane Doe')
      end

      it 'redirects to the proof_of_identity path' do
        expect(response).to redirect_to(proof_of_identity_path)
      end

      it 'sets a success notice' do
        expect(flash[:notice]).to eq('Customer info was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      before do
        session[:user_id] = user.id
        request.env['HTTP_REFERER'] = general_info_path
        allow_any_instance_of(User).to receive(:update).and_return(false)
        post :update_db, params: { user: { id: user.id, display_name: '' } }
      end

      it 'does not update the user' do
        expect(user.display_name).not_to eq('')
      end

      it 're-renders the general_info template' do
        expect(response).to render_template(:general_info)
      end

      it 'sets an alert message' do
        expect(flash[:alert]).to eq('Update failed.')
      end
    end
  end
end