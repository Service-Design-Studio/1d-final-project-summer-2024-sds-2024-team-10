require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  it 'successfully connects' do
    # Simulate the connection
    connect "/cable"

    # Check that the connection has been established
    expect(connection).to be_an_instance_of(ApplicationCable::Connection)
  end
end