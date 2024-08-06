Rails.application.routes.draw do
  root 'login#home'

  get 'change_locale/:locale', to: 'application#change_locale', as: :change_locale

  get '/signup', to: 'login#signup', as: 'signup'
  post 'signup', to: 'login#signup_authentication', as: 'signup_authentication'

  get '/login', to: 'login#login', as: 'login'
  post 'login', to: 'login#login_authentication', as: 'login_authentication'

  get '/existing_customer', to: 'existing_customer#home', as: 'existing_customer_home'

  # Route for generating OTP
  get '/otp', to: 'otp#create', as: 'generate_otp'

  # Route for displaying the OTP verification form
  get '/otp/verify', to: 'otp#otp', as: 'otp_verification'

  # Route for verifying the OTP
  post '/otp/verify_otp', to: 'otp#verify_otp', as: 'verify_otp'

  get '/singpass', to: 'singpass#singpass', as: 'singpass'

  get '/checklist', to: 'checklist#checklist', as: 'checklist'
  post 'checklist', to: 'checklist#next'

  get '/general_info', to: 'customer_info#general_info', as: 'general_info'
  post 'customer_info/update_db', to: 'customer_info#update_db', as: 'update_db'

  get '/taxres', to: 'customer_info#taxres', as: 'taxres'

  # Routes for Document upload
  get '/proof_of_identity', to: 'docs_upload#proof_of_identity'
  get '/test', to: 'docs_upload#test'
  get '/camera/identity', to: 'docs_upload#upload_proof_of_identity'
  post '/camera/identity', to: 'camera#identity'

  get '/proof_of_employment', to: 'docs_upload#proof_of_employment'
  get '/camera/employment', to: 'docs_upload#upload_proof_of_employment'
  post '/camera/employment', to: 'camera#employment'

  get '/proof_of_residential', to: 'docs_upload#proof_of_residential'
  get '/camera/address', to: 'docs_upload#upload_proof_of_residential'
  post '/camera/address', to: 'camera#address'

  get '/proof_of_taxres', to: 'docs_upload#proof_of_taxres'
  get '/camera/tax', to: 'docs_upload#upload_proof_of_taxres'
  post '/camera/tax', to: 'camera#tax'

  get '/proof_of_mobile', to: 'docs_upload#proof_of_mobile'
  get '/camera/mobile', to: 'docs_upload#upload_proof_of_mobile'
  post '/camera/mobile', to: 'camera#mobile'

  get '/summary_page', to: 'summary_page#summary_page', as: 'summary_page'
  post 'summary_page/update_db', to: 'summary_page#update_db', as: 'summary_update_db'

  get '/end_of_application', to: 'summary_page#end_of_application', as: 'end_of_application'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users
  # Defines the root path route ("/")
end
