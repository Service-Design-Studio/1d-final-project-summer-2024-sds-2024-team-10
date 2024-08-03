Rails.application.routes.draw do
  root 'login#login'

  get '/login', to: 'login#login', as: 'login'
  post 'login', to: 'login#login', as: 'login_authentication'

  get '/existing_customer', to: 'existing_customer#home', as: 'existing_customer_home'

  # Route for generating OTP
  get '/otp', to: 'otp#create', as: 'generate_otp'

  # Route for displaying the OTP verification form
  get '/otp', to: 'otp#otp', as: 'otp_verification'

  # Route for verifying the OTP
  post '/otp/verify_otp', to: 'otp#verify_otp', as: 'verify_otp'

  get '/singpass', to: 'singpass#singpass', as: 'singpass'

  get '/checklist', to: 'checklist#checklist', as: 'checklist'
  post 'checklist', to: 'checklist#next'

  get '/general_info', to: 'customer_info#general_info', as: 'general_info'
  post 'customer_info/update_db', to: 'customer_info#update_db', as: 'update_db'

  get '/taxres', to: 'customer_info#taxres', as: 'taxres'

  get '/proof_of_identity', to: 'docs_upload#proof_of_identity', as: 'proof_of_identity'
  get '/proof_of_residential', to: 'docs_upload#proof_of_residential', as: 'proof_of_residential'
  get '/proof_of_employment', to: 'docs_upload#proof_of_employment', as: 'proof_of_employment'
  get '/proof_of_mobile', to: 'docs_upload#proof_of_mobile', as: 'proof_of_mobile'
  get '/proof_of_taxres', to: 'docs_upload#proof_of_taxres', as: 'proof_of_taxres'

  get '/upload/proof_of_identity', to: 'docs_upload#upload_proof_of_identity', as: 'upload_proof_of_identity'
  get '/upload/proof_of_residential', to: 'docs_upload#upload_proof_of_residential', as: 'upload_proof_of_residential'
  get '/upload/proof_of_employment', to: 'docs_upload#upload_proof_of_employment', as: 'upload_proof_of_employment'
  get '/upload/proof_of_mobile', to: 'docs_upload#upload_proof_of_mobile', as: 'upload_proof_of_mobile'
  get '/upload/proof_of_taxres', to: 'docs_upload#upload_proof_of_taxres', as: 'upload_proof_of_taxres'
  post '/camera/process', to: 'ocr#process'

  get '/summary_page', to: 'summary_page#summary_page', as: 'summary_page'
  get '/end_of_application', to: 'summary_page#end_of_application', as: 'end_of_application'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users
  # Defines the root path route ("/")
end
