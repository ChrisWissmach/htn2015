Rails.application.routes.draw do

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  get 'signup' => 'users#new'

  resources :users do
  	resources :pictures
  end

  resources :sessions

  post "users/create_picture"

  post "competition/elo"

  
  root 'application#index'


end
