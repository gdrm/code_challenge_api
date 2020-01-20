Rails.application.routes.draw do
  get '/challenges', to: 'challenges#index', :defaults => { :format => 'json' }
  get '/challenges/:id', to: 'challenges#show', :defaults => { :format => 'json' }
  post '/login', to: 'authentication#authenticate', :defaults => { :format => 'json' }
end
