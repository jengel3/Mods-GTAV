Rails.application.routes.draw do
  # devise_for :users, :controllers => { sessions: 'sessions', registrations: 'registrations', :omniauth_callbacks => 'users/omniauth_callbacks', :passwords => 'passwords' }
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  
  resources :submissions do
    resources :images
    resources :comments
  end

  root 'submissions#index'

  get '/p/:username', to: 'application#profile', as: 'profile'

  namespace :api, defaults: { :format => :json } do
    namespace :v1 do
      resources :submissions do
        resources :comments
        resources :images
        resources :uploads
      end
    end
  end
end
