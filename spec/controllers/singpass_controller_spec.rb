# spec/controllers/singpass_controller_spec.rb
require 'rails_helper'

RSpec.describe SingpassController, type: :controller do
  it 'exists' do
    expect(SingpassController.new).to be_an_instance_of(SingpassController)
  end

  it 'inherits from ApplicationController' do
    expect(SingpassController < ApplicationController).to be true
  end
end