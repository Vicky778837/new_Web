Rails.application.routes.draw do
  resources :articles
  resources :users
  get '/signup', to: 'users#new'
  root 'articles#home'
  get 'profile', to: 'users#profile'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'password_resets/new'
  resources :password_resets
  get 'change_password' => 'users#change_password'
  patch 'update_password' => 'users#update_password'
end
