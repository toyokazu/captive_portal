Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :agreement
  resources :auth_providers
  resource :ap_auth_handler
  #resource :hash_salt
  get '/auth/:provider', to: lambda{|env| [404, {}, ["Not Found"]]}, as: 'auth'
  get '/auth/identity/register', as: 'auth_identity_register'
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
end
