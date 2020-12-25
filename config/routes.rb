Rails.application.routes.draw do
  devise_for :users
  root to: 'turns#index'

  resources :turns

  namespace :admin do
    resources :users
  end
  
end
