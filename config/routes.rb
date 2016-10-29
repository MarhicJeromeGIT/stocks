Rails.application.routes.draw do
  root to: 'static_pages#welcome'
  
  get 'welcome', to: 'static_pages#welcome'
  get 'about', to: 'static_pages#about'
  
  resources :stocks
  resources :alerts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
