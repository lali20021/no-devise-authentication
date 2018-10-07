Rails.application.routes.draw do

  root 'pages#index'
  get '/help',    to: 'pages#help'
  get 'signup',   to: 'users#new'

  resources :users
end
