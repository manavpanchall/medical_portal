# config/routes.rb
Rails.application.routes.draw do
    get '/login' => 'sessions#new', as: 'login'
    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy', as: 'logout'
  
    namespace :receptionist do
      resources :patients
    end
  
    namespace :doctor do
      get '/analytics' => 'analytics#index'
      resources :patients, only: [:index, :show]
    end
  
    root 'sessions#new'
  end