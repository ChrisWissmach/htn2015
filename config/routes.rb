Rails.application.routes.draw do

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  get 'signup' => 'users#new'

  resources :users
  resources :sessions

  
  root 'application#index'


end
