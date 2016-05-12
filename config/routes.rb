Rails.application.routes.draw do
  root to: 'static_pages#root'

  # TODO static pages and custom routes
  get 'about', to: 'static_pages#about'
  get 'nickbarry', to: redirect('https://github.com/itsnickbarry')

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:show]
    resource :session, only: [:show]

    resources :characters, only: [:show, :index, :create]
    resources :fractions, only: [:show, :index, :create], shallow: true do
      resources :electorates, only: [:show, :index, :create, :destroy]
      resources :positions,   only: [:show, :index, :create, :destroy]
      resources :regions,     only: [:show, :index, :create, :destroy]
    end
    resources :government_authorizations, only: [:create, :destroy]
    get 'plot_authorizations/:uuid/:world_id/:x/:z', to: 'plot_authorizations#show'
  end
end
