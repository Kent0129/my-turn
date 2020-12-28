Rails.application.routes.draw do
  devise_for :users
  root to: 'turns#index'

  resources :turns



end
