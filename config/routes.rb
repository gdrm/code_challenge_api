Rails.application.routes.draw do
  get '/challenges', to: 'challenges#index', :defaults => { :format => 'json' }
  post '/login', to: 'authentication#authenticate', :defaults => { :format => 'json' }
end
