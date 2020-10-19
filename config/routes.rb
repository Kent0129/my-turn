Rails.application.routes.draw do
  root to: 'turns#index'
  resources :turns
end
