Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :agreement
  resource :auth_provider
  resource :ap_auth_handler
  get '/auth/:provider', to: lambda{|env| [404, {}, ["Not Found"]]}, as: 'auth'
  get '/auth/:provider/callback', to: 'sessions#create'
end
