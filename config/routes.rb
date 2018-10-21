Rails.application.routes.draw do

  get 'sessions/new'

  root 'pages#index'
  get '/help',      to: 'pages#help'
  get 'signup',     to: 'users#new'

  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  resources :users
  resources :account_activation, only: [:edit]
end
