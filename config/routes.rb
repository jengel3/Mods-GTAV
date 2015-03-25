Rails.application.routes.draw do
  devise_for :users
  
  resources :submissions do
    resources :comments
  end

  root 'submissions#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :submissions do
        resources :comments
      end
    end
  end
end
