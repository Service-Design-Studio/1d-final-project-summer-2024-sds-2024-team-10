Rails.application.routes.draw do
  root 'login#login'

  get '/login', to: 'login#login', as: 'login'

  get '/otp', to: 'otp#otp', as: 'otp_verification'

  post 'otp/create', to: 'otp#create', as: 'create_otp'
  post 'otp/verify_otp', to: 'otp#verify_otp', as: 'verify_otp'

  get '/singpass', to: 'singpass#singpass', as: 'singpass'

  get '/checklist', to: 'checklist#checklist', as: 'checklist'
  post '/checklist', to: 'checklist#next'

  get '/general_info', to: 'customer_info#general_info', as: 'general_info'

  get '/taxres', to: 'customer_info#taxres', as: 'taxres'

  get '/proof_of_identity', to: 'ocr#proof_of_identity', as: 'proof_of_identity'

  get '/upload/camera', to: 'ocr#camera', as: 'camera'

  get '/proof_of_employment', to: 'ocr#proof_of_employment', as: 'proof_of_employment'

  post '/camera/process', to: 'ocr#process'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users
  # Defines the root path route ("/")
end
