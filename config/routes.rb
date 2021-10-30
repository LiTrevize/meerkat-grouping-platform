Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'sessions#index'
  # Routes for Google authentication
  get '/auth/:provider/callback', to: 'sessions#googleAuth'
  get '/auth/failure', to: redirect('/')
  delete 'logout', to: 'sessions#logout'

  # /profiles
  resource :profiles

  # /posts
  get '/posts', to: 'posts#index', as: 'posts_path'
  resource :posts
end
