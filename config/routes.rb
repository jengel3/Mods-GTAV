Rails.application.routes.draw do
  get 'comments/create'

  get 'submissions/index'

  get 'submissions/show'

  get 'submissions/new'

  get 'submissions/edit'

  devise_for :users
  
  resources :submissions do
    resources :comments
  end

  root 'submissions#index'

  namespace :api do
    resources :submissions, defaults: { format: :json }
  end
end
