Rails.application.routes.draw do
  # devise_for :users, :controllers => { sessions: 'sessions', registrations: 'registrations', :omniauth_callbacks => 'users/omniauth_callbacks', :passwords => 'passwords' }
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  
  resources :submissions do
    resources :images
    resources :comments do
      post :like
    end
    post :like
    post :dislike
  end

  get '/c/(:category/(:subcategory))', to: 'submissions#index', as: 'category'

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
