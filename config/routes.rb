Rails.application.routes.draw do
  devise_for :users
  resources :users
  namespace :api do
    post 'sign_in_token', to: 'api_application#sign_in'
    get 'users/me', to: 'users#me'
    get 'alerts', to: 'alerts#alerts'
    resources :stocks, only: [:index] do
      get 'search', on: :collection
    end
  end

  root to: 'static_pages#welcome'

  get 'auth/facebook/callback', to: 'users#facebook'

  # For the swagger json api definition generation
  resources :apidocs, only: [:index]
  
  get 'welcome', to: 'static_pages#welcome'
  get 'about', to: 'static_pages#about'
  get 'apidocs', to: 'apidocs#index'
  

  resources :stocks do
    get 'search', on: :collection
    get 'elastic', on: :collection
  end
  resources :alerts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
