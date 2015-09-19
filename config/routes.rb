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

  post "competition/get_pictures"

  
  root 'application#index'


end
