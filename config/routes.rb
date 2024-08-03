Rails.application.routes.draw do
  resources :customer_records
  root 'home#index'

  get '/singpass', to: 'home#new', as: 'new'
  get '/signup', to: 'home#signup'
  get '/address', to: 'home#addressform'
  get '/work', to: 'home#work'
  get '/industry', to: 'home#industry'
  get '/taxres', to: 'home#taxres'
  get '/mobileno', to: 'home#mobileno'
  get '/login', to: 'home#login'
  get '/otp', to: 'home#otp', as: 'verify_otps'
  get '/application', to: 'home#application'

  post '/application/reload', to: 'home#reload_application_draft', as: 'reload_application_draft'

  get '/extracted_data', to: 'home#extracted_data'

  # Handle language switch
  post 'switch_language', to: 'home#switch_language'

  # Routes for Chinese language
  get 'signup_chi', to: 'home#signup_chi', as: 'signup_chi'
  post 'signup_chi', to: 'home#signup_chi'
  get 'new_chi', to: 'home#new_chi', as: 'new_chi'
  get 'checklist_chi', to: 'checklist#checklist_chi', as: 'checklist_chi'

  # Routes for Tamil language
  get 'signup_ta', to: 'home#signup_ta', as: 'signup_ta'
  post 'signup_ta', to: 'home#signup_ta'
  get 'new_ta', to: 'home#new_ta', as: 'new_ta'
  get 'checklist_ta', to: 'checklist#checklist_ta', as: 'checklist_ta'

  get '/checklist', to: 'checklist#checklist'
  get '/checklist/passport', to: 'checklist#passport'
  get '/checklist/employment', to: 'checklist#employment'
  get '/checklist/mobile', to: 'checklist#mobile'
  get '/checklist/address', to: 'checklist#address'
  get '/checklist/tax', to: 'checklist#tax'
  post '/checklist', to: 'hsome#address'

  get '/checklist/:item', to: 'checklist#show', as: 'checklist_item'
  
  # Routes for Document upload
  get '/proof_of_identity', to: 'upload#proof_of_identity'
  get '/camera/identity', to: 'upload#camera_identity'
  post '/camera/identity', to: 'camera#identity'

  get '/proof_of_employment', to: 'upload#proof_of_employment'
  get '/camera/employment', to: 'upload#camera_employment'
  post '/camera/employment', to: 'camera#employment'

  get '/proof_of_address', to: 'upload#proof_of_address'
  get '/camera/address', to: 'upload#camera_address'
  post '/camera/address', to: 'camera#address'

  get '/proof_of_tax', to: 'upload#proof_of_tax'
  get '/camera/tax', to: 'upload#camera_tax'
  post '/camera/tax', to: 'camera#tax'

  get '/proof_of_mobile', to: 'upload#proof_of_mobile'
  get '/camera/mobile', to: 'upload#camera_mobile'
  post '/camera/mobile', to: 'camera#mobile'

  get '/summary', to: 'summary#summary', as: 'summary'
  
  post 'otps/create', to: 'otps#create', as: 'create_otps'
  post 'otps/verify_otp', to: 'otps#verify_otp', as: 'verify_otp'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
end
