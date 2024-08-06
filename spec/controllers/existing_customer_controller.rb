# spec/controllers/existing_customer_controller_spec.rb
require 'rails_helper'

RSpec.describe ExistingCustomerController, type: :controller do
  it 'exists' do
    expect(ExistingCustomerController.new).to be_an_instance_of(ExistingCustomerController)
  end

  it 'inherits from ApplicationController' do
    expect(ExistingCustomerController < ApplicationController).to be true
  end
end
