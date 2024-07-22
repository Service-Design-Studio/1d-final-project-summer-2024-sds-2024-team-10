Rails.application.routes.draw do
  root 'home#index'

  get '/new', to: 'home#new'
  get '/signup', to: 'home#signup'
  get '/address', to: 'home#addressform'
  get '/work', to: 'home#work'
  get '/industry', to: 'home#industry'
  get '/taxres', to: 'home#taxres'
  get '/mobileno', to: 'home#mobileno'

  get '/proof_of_identity', to: 'upload#proof_of_identity'

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
  post '/checklist', to: 'home#address'

  get '/checklist/:item', to: 'checklist#show', as: 'checklist_item'

  get '/upload', to: 'upload#upload'
  get '/upload/camera', to: 'upload#camera'
  get '/upload/files', to: 'upload#files'



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
end
