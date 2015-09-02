Rails.application.routes.draw do
  root to: 'static_pages#root'

  # TODO static pages and custom routes
  get 'about', to: 'static_pages#about'
  get 'nickbarry', to: redirect('https://github.com/itsnickbarry')

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:show]
    resources :characters, only: [:show, :index, :create]
    resources :fractions, only: [:show, :index, :create]
    resources :positions, only: [:show, :index, :create, :destroy]
    resources :electorates, only: [:show, :index, :create, :destroy]
    resources :regions, only: [:show, :index, :create, :destroy]
    resources :government_authorizations, only: [:create, :destroy]
    get 'session', to: 'sessions#show'
  end
end
