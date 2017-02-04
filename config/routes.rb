Rails.application.routes.draw do
  devise_for :users
  resources :users
  namespace :api do
    post 'sign_in_token', to: 'api_application#sign_in'
  end

  root to: 'static_pages#welcome'

  # For the swagger json api definition generation
  resources :apidocs, only: [:index]
  
  get 'welcome', to: 'static_pages#welcome'
  get 'about', to: 'static_pages#about'
  get 'apidocs', to: 'apidocs#index'
  
  resources :stocks
  resources :alerts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
