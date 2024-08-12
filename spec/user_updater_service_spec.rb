require 'rails_helper'

RSpec.describe UserUpdaterService, type: :service do
  describe '.update_user' do
    let!(:user) do
      User.create(
        full_name: "John Doe",
        display_name: "John",
        phone_number: "1234567890",
        password: "password123",
        email: "john.doe@example.com"
      )
    end

    let(:updates_hash) do
      { full_name: "Jane Doe", email: "jane.doe@example.com" }
    end

    it 'updates the user with the provided attributes' do
      UserUpdaterService.update_user(user.id, updates_hash)
      user.reload

      expect(user.full_name).to eq("Jane Doe")
      expect(user.email).to eq("jane.doe@example.com")
    end

    it 'raises an error if the user is not found' do
      expect {
        UserUpdaterService.update_user(-1, updates_hash)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end