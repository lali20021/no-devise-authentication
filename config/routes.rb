Rails.application.routes.draw do

  get 'password_reset/new'
  get 'password_reset/edit'
  get 'sessions/new'

  root 'pages#index'
  get '/help',      to: 'pages#help'
  get 'signup',     to: 'users#new'

  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  resources :users
  resources :account_activation, only: [:edit]
  resources :password_reset, only: [:new, :create, :edit, :update]
end
