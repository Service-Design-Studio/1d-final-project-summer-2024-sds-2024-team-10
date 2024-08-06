require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) do
    User.create(
      full_name: "John Doe Pink",
      display_name: "John Doe",
      phone_number: "1234567890",
      password: "password",
      email: "john.doe@example.com"
    )
  end

  describe '.find_record' do
    context 'when the user is found' do
      it 'returns the user and logs a message' do
        expect { User.find_record(email: user.email) }
          .to output("User db record found\n").to_stdout
        expect(User.find_record(email: user.email)).to eq(user)
      end
    end

    context 'when the user is not found' do
      it 'returns nil and logs a message' do
        expect { User.find_record(email: 'nonexistent@example.com') }
          .to output("User db record not found\n").to_stdout
        expect(User.find_record(email: 'nonexistent@example.com')).to be_nil
      end
    end
  end

  describe '.authenticate_password' do
    context 'when the password is correct' do
      it 'returns true and logs a message' do
        expect { User.authenticate_password(user, 'password') }
          .to output("User pw correct\n").to_stdout
        expect(User.authenticate_password(user, 'password')).to be true
      end
    end

    context 'when the password is incorrect' do
      it 'returns false and logs a message' do
        expect { User.authenticate_password(user, 'wrongpassword') }
          .to output("User pw incorrect\n").to_stdout
        expect(User.authenticate_password(user, 'wrongpassword')).to be false
      end
    end
  end
end
