Rails.application.routes.draw do
  devise_for :users, :controllers => { sessions: 'users/sessions', registrations: 'users/registrations', :omniauth_callbacks => 'users/omniauth_callbacks', :passwords => 'users/passwords' }
  
  resources :submissions do
    resources :images
    resources :comments do
      post :like
    end
    resources :uploads do
      post :approve
      post :deny
      get :download
    end
    post :like
    post :dislike
    get :download
  end

  resources :videos

  post '/contact', to: 'application#contact', as: 'contact'
  get '/search', to: 'application#search', as: 'search'

  get '/c/(:category/(:subcategory))', to: 'submissions#index', as: 'category'

  get '/home', to: 'home#index'
  get '/home/infinite', to: 'home#infinite'
  root 'home#index'

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

  namespace :admin do
    get '/', to: 'home#index', as: 'home'
    get '/content', to: 'content#index', as: 'content'
    post '/flush', to: 'home#flush', as: 'flush'
  end
end
