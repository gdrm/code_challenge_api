Rails.application.routes.draw do
  get '/challenges', to: 'challenges#index', :defaults => { :format => 'json' }
  get '/challenges/:id', to: 'challenges#show', :defaults => { :format => 'json' }
  post '/login', to: 'authentication#authenticate', :defaults => { :format => 'json' }
<<<<<<< HEAD
  get 'challenges/:challenge_id/solutions', to: 'solutions#index'
  get 'users/:user_id/solutions', to: 'solutions#user', :defaults => { :format => 'json' }
  post 'challenges/:challenge_id/solutions', to: 'solutions#create', :defaults => { :format => 'json' }
=======
  post '/users/:id', to: 'user#edit', :defaults => { :format => 'json' }
>>>>>>> add edit action to user_controller
end
