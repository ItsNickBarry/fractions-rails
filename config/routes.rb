Rails.application.routes.draw do
  root to: 'static_pages#root'

  get 'about', to: 'static_pages#about'

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  namespace :api, defaults: { format: :json } do
    resource :session, only: [:show]

    resources :users, only: [:show]

    resources :characters, only: [:show, :index, :create], shallow: true do
      resources :fraction_invitations, only: [:show, :index, :destroy]
    end

    resources :fractions, only: [:show, :index, :create, :update], shallow: true do
      resources :electorates, only: [:show, :index, :create, :destroy]
      resources :positions,   only: [:show, :index, :create, :destroy]
      resources :regions,     only: [:show, :index, :create, :destroy]
    end

    resources :government_authorizations, only: [:create, :destroy]
    # get 'plot_authorizations/:uuid/:world_id/:x/:z', to: 'plot_authorizations#show'
  end
end
