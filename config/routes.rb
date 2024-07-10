Rails.application.routes.draw do
  root 'home#index'

  get '/about', to: 'home#about'
  get '/contact', to: 'home#contact'
  get '/new', to: 'home#new'
  get '/signup', to: 'home#signup'

  get '/checklist', to: 'checklist#checklist'
  get '/checklist/passport', to: 'checklist#passport'
  get '/checklist/employment', to: 'checklist#employment'
  get '/checklist/mobile', to: 'checklist#mobile'
  get '/checklist/address', to: 'checklist#address'
  get '/checklist/tax', to: 'checklist#tax'

  get '/checklist/:item', to: 'checklist#show', as: 'checklist_item'
  post '/submit_checklist', to: 'checklist#submit_checklist'

  get '/upload', to: 'home#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
end
