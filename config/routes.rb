Rails.application.routes.draw do
  devise_for :users
  
  root 'application#index'

  namespace :api do
    resources :submissions, defaults: { format: :json }
  end

  get '*path', to: 'application#index'
end
