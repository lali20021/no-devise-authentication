Rails.application.routes.draw do

  root 'pages#index'
  get '/help', to: 'pages#help'

  resources :users
end
