Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'sessions#index'
  # Routes for Google authentication
  get '/auth/:provider/callback', to: 'sessions#googleAuth'
  get '/auth/failure', to: redirect('/')
  delete 'logout', to: 'sessions#logout'

  # /profiles
  get '/profile', to: 'profiles#show', as: 'profile'
  get '/profile/new', to: 'profiles#new', as: 'new_profile'
  post '/profile', to: 'profiles#create'
  put '/profile/:id', to: 'profiles#update', as: 'put_profile'

  # /posts
  get '/posts', to: 'posts#index', as: 'posts'
  post '/posts', to: 'posts#create', as: 'create_post'
  delete '/post/:id', to: 'posts#destroy', as: 'del_post'
  get '/post/:id', to: 'posts#show', as: 'post'
  get '/post/:id/edit', to: 'posts#edit', as: 'edit_post'
  put '/post/:id', to: 'posts#update', as: 'update_post'
  get '/posts/new', to: 'posts#new', as: 'new_post'

  # group
  post '/post/:id/apply', to: 'groups#apply', as: "apply"
  
  post '/post/:id/approve/:user_id', to: 'groups#approve'
  post '/post/:id/reject/:user_id', to: 'groups#reject'
  post '/post/:id/accept', to: 'groups#accept', as: "accept"
  post '/post/:id/refuse', to: 'groups#refuse', as: "refuse"
  get '/group/:id', to: 'groups#show'
end
