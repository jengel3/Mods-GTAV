Rails.application.routes.draw do
  devise_for :users
  
  resources :submissions do
    resources :comments
  end

  root 'submissions#index'

  namespace :api do
    resources :submissions, defaults: { format: :json }
  end
end
