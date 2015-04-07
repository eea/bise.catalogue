require 'sidekiq/web'

Catalogue::Application.routes.draw do


  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
    mount Redmon::App  => '/redmon'
  end

  get 'help' => 'help#index', as: 'help'
  # comfy_route :cms_admin, path: '/cmsadmin'
  # comfy_route :cms, path: '/help', sitemap: false

  root to: 'home#index'

  devise_for :users, controllers: {registrations: 'users/registrations'}
  as :user do
    get 'biseadmin/users/:id/edit', to: 'users/registrations#edit', as: 'edit_user_registration'
    put 'biseadmin/users/:id' => 'users/registrations#update', as: 'user_registration'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "home/index"

  resources :articles do
    collection do
      get :search
      post :approve_multiple
    end
  end

  resources :documents do
    collection do
      post :approve_multiple
    end
  end

  resources :links do
    collection do
      post :approve_multiple
    end
  end

  resources :news
  resources :protected_areas
  resources :habitats
  resources :species

  # ----- API -----
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :sites, only: :show
      resources :ecosystem_assessments
      resources :stats, only: :index

      get 'bise_search' => 'search#bise_search'
      get 'search'      => 'search#advanced_search'

      post 'sync'       => 'sync#create'
      put 'sync'        => 'sync#update'
      delete 'sync'     => 'sync#delete'

      get 'shared_tags'   , controller: 'tag', action: 'all_tags'
      get 'shared_targets', controller: 'tag', action: 'all_targets'
    end
  end

  # ----- Bise Admin -----
  namespace :biseadmin do
    resources :users, except: [:create]
    resources :sites
    resources :keyword_containers
    resources :keywords
    resources :targets
    resources :strategy_actions
    resources :unprocessed_objects, only: [:index, :show]
  end

  resources :statistics, only: [:index]
end
