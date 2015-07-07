Rails.application.routes.draw do
  root to: 'static_pages#root'
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:show]
    resources :characters, only: [:show, :index, :create]
    resources :fractions, only: [:show, :index, :create]
    resources :positions, only: [:show, :index, :create, :destroy]
  end
end
