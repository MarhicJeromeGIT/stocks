Rails.application.routes.draw do

  devise_for :users
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
  resources :users
  
  root to: 'static_pages#welcome'

  # For the swagger json api definition generation
  resources :apidocs, only: [:index]
  
  get 'welcome', to: 'static_pages#welcome'
  get 'about', to: 'static_pages#about'
  
  resources :stocks
  resources :alerts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
