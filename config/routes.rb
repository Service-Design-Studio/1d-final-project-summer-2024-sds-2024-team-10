Rails.application.routes.draw do
  root 'home#index'

  get 'about', to: 'home#about'
  get 'contact', to: 'home#contact'

  get 'checklist', to: 'checklist#checklist'
  get 'checklist/passport', to: 'checklist#passport'
  get 'checklist/proof_of_employment', to: 'checklist#proof_of_employment'
  get 'checklist/proof_of_mobile_ownership', to: 'checklist#proof_of_mobile_ownership'
  get 'checklist/proof_of_residential_address', to: 'checklist#proof_of_residential_address'
  get 'checklist/proof_of_tax_residency', to: 'checklist#proof_of_tax_residency'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
end
