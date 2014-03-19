Catalogue::Application.routes.draw do

  root to: 'home#index'

  devise_for :users

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
      match '/bise_search' => 'search#bise_search'
      match '/search' => 'search#index'
      post '/sync' => 'sync#create'
      put '/sync' => 'sync#update'
      delete '/sync' => 'sync#delete'
    end
  end

  # Admin
  namespace :admin do
    resources :sites
  end

  # ECOSYSTEM ASSESMENT
  # resources :ecosystem_assessments

  # scope '/api' do
  #   match '/search' => 'search#index'
  #   post '/sync' => 'sync#create'
  #   put '/sync' => 'sync#update'
  #   delete '/sync' => 'sync#delete'
  # end

end
