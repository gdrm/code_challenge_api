Rails.application.routes.draw do
  post '/login', to: 'authentication#authenticate', :defaults => { :format => 'json' }
end
