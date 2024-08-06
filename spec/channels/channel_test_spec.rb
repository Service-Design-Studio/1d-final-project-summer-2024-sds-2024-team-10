# spec/channels/application_cable/channel_spec.rb
require 'rails_helper'

RSpec.describe ApplicationCable::Channel, type: :channel do
  it 'is defined' do
    expect(defined?(ApplicationCable::Channel)).to eq('constant')
  end

  it 'inherits from ActionCable::Channel::Base' do
    expect(ApplicationCable::Channel).to be < ActionCable::Channel::Base
  end
end
