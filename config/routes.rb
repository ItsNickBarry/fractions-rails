Rails.application.routes.draw do
  root to: 'static_pages#home'
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :characters, only: [:show]

  namespace :api, defaults: { format: :json } do
    # resources :users, only: [:show]
    # resources :characters, only: [:show, :index, :create, :destroy]
  end
end
