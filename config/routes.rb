Rails.application.routes.draw do
  get '/challenges', to: 'challenges#index', :defaults => { :format => 'json' }
  get '/challenges/:id', to: 'challenges#show', :defaults => { :format => 'json' }
  post '/login', to: 'authentication#authenticate', :defaults => { :format => 'json' }
  get 'challenges/:challenge_id/solutions', to: 'solutions#index'
  get 'users/:user_id/solutions', to: 'solutions#user', :defaults => { :format => 'json' }
  post 'challenges/:challenge_id/solutions', to: 'solutions#create', :defaults => { :format => 'json' }
  put '/users/:id', to: 'user#edit', :defaults => { :format => 'json' }
  get 'challenges/:challenge_id/solution', to: 'solutions#show', :defaults => { :format => 'json' }
  put 'challenges/:challenge_id/solution', to: 'solutions#update', :defaults => { :format => 'json' }
  post 'solutions/:solution_id/comments', to: 'comments#create', :defaults => { :format => 'json' }
end
