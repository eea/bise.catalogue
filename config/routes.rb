Catalogue::Application.routes.draw do

  root to: 'home#index'

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  get "home/index"

  # SITES
  # resources :sites

  # ARTICLES
  resources :articles do
    collection do
      get :search
      post :approve_multiple
    end
  end

  # DOCUMENTS
  resources :documents do
    collection do
      post :approve_multiple
    end
  end

  # LINKS
  resources :links do
    collection do
      post :approve_multiple
    end
  end

  # NEWS
  resources :news

  # EUNIS (Species, Sites, Habitats)
  resources :protected_areas
  resources :habitats
  resources :species

  # API
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :ecosystem_assessments
      get 'bise_search' => 'search#bise_search'
      get 'search'      => 'search#index'

      post 'sync'       => 'sync#create'
      put 'sync'        => 'sync#update'
      delete 'sync'     => 'sync#delete'

      get 'shared_tags', controller: 'tag', action: 'all_tags'
    end
  end

  # Bise Admin
  namespace :biseadmin do
    resources :sites
    resources :keyword_containers
    resources :keywords
    resources :targets
    resources :actions
  end

  # ECOSYSTEM ASSESMENT
  # resources :ecosystem_assessments

  # scope '/api' do
  #   get '/search' => 'search#index'
  #   post '/sync' => 'sync#create'
  #   put '/sync' => 'sync#update'
  #   delete '/sync' => 'sync#delete'
  # end

end
