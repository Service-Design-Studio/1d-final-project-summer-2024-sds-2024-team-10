# spec/controllers/login_controller_spec.rb
require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  let(:user) do
    User.create(
      display_name: "JohnDoe",
      phone_number: "1234567890",
      full_name: "John Doe",
      password: "password",
      application_status: "pending"
    )
  end

  describe 'POST #login_authentication' do
    context 'when user is found' do
      before do
        allow(User).to receive(:find_record).with(display_name: "JohnDoe").and_return(user)
      end

      context 'with correct password' do
        before do
          allow(User).to receive(:authenticate_password).with(user, "password").and_return(true)
        end

        it 'sets the session user_id' do
          post :login_authentication, params: { display_name: "JohnDoe", password: "password" }
          expect(session[:user_id]).to eq(user.id)
        end

        context 'when application status is approved' do
          before do
            user.update(application_status: "approved")
          end

          it 'redirects to existing customer home path' do
            post :login_authentication, params: { display_name: "JohnDoe", password: "password" }
            expect(response).to redirect_to(existing_customer_home_path)
          end
        end

        context 'when application status is not approved' do
          it 'redirects to login path with alert' do
            post :login_authentication, params: { display_name: "JohnDoe", password: "password" }
            expect(response).to redirect_to(login_path)
            expect(flash[:alert]).to eq('Account Application Incomplete, click Sign Up to complete application')
          end
        end
      end

      context 'with incorrect password' do
        before do
          allow(User).to receive(:authenticate_password).with(user, "wrongpassword").and_return(false)
        end

        it 'redirects to login path with alert' do
          post :login_authentication, params: { display_name: "JohnDoe", password: "wrongpassword" }
          expect(response).to redirect_to(login_path)
          expect(flash[:alert]).to eq('Wrong credentials, please try again.')
        end
      end
    end
  end

  describe 'POST #signup_authentication' do
    context 'when user is found' do
      before do
        allow(User).to receive(:find_record).with(phone_number: "1234567890").and_return(user)
      end

      context 'when full_name matches' do
        it 'sets the session user_id and redirects based on application status' do
          post :signup_authentication, params: { phone_number: "1234567890", full_name: "John Doe" }
          expect(session[:user_id]).to eq(user.id)

          if user.application_status == "approved"
            expect(response).to redirect_to(signup_path)
            expect(flash[:alert]).to eq('Account Application Complete, click Log In to proceed')
          else
            expect(response).to redirect_to(generate_otp_path)
            expect(session[:application_record]).to be_truthy
          end
        end
      end

      context 'when full_name does not match' do
        it 'sets the recovery_phone_number session variable and creates new record' do
          expect(controller).to receive(:create_new_record)
          post :signup_authentication, params: { phone_number: "1234567890", full_name: "Jane Doe" }
          expect(session[:recovery_phone_number]).to be_truthy
        end
      end
    end

    context 'when user is not found' do
      before do
        allow(User).to receive(:find_record).with(phone_number: "0987654321").and_return(nil)
      end

      it 'creates a new user record' do
        expect {
          post :signup_authentication, params: { phone_number: "0987654321", full_name: "Jane Doe" }
        }.to change(User, :count).by(1)
        new_user = User.last
        expect(session[:user_id]).to eq(new_user.id)
        expect(response).to redirect_to(generate_otp_path)
      end
    end
  end
end
