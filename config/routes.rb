Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins, controllers:{
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }
  devise_for :owners, controllers:{
    registrations: 'owners/registrations',
    sessions: 'owners/sessions'
  }

  devise_for :clients, controllers:{
    registrations: 'ad_clients/registrations',
    sessions: 'ad_clients/sessions'
  }
  root :to => 'homes#index'
  get 'homes/index'
  get 'homes/about'

  resources :admins, only:[:index]
  namespace :admins do
  resources :ad_clients, only: [:index, :show, :update]
  resources :owners, only: [:index, :show, :update]
  resources :genres, only: [:index, :create, :edit, :update, :destroy]
  resources :contacts, only: [:index,:show]
  end

  resources :ad_clients, only:[:index, :show, :edit, :update]do
  member do
  get :dashboard
  get :followings, :followers
  end
  scope module: :ad_clients do
  resources :complete_deals, only:[:index, :show, :create, :edit, :update]
  resources :ads
  end
  end

  resources :os_owners, only:[:index, :show, :edit, :update]do
  member do
  get :dashboard
  get :followings, :followers
  patch :is_active
  end
  resources :car_informations, only:[:index, :create, :edit, :update, :destroy]
  resources :transfer_informations, only:[:index, :create, :edit, :update, :destroy]
  end
  # resources :relationship_drivers, only:[:create, :destroy]
  #広告主→ドライバーへのフォロー動作
  #post 'relationships/:ad_client_id', to: 'relationship_drivers#create', as:'relationship_drivers'
  #delete 'relationships/:ad_client_id', to: 'relationship_drivers#destroy'
  #ドライバー→広告主へのフォロー動作
  #post '/relationships/:driver_id',to: 'relationships#create',as:'relationships'
  #delete '/relationships/:driver_id',to: 'relationships#destroy'
  #広告主検索
  #get '/search_ad_client', to: 'searchs#search_ad_client'
  #ドライバー検索
  #get '/search_driver', to: 'searchs#search_driver'

  resources :deal_details, only:[:index, :create, :update]
  resources :completed_deals, only:[:index, :show, :update]
  resources :informations

  resources :under_deals, only:[:index, :show, :create, :edit,:update]do
  member do
  get :show_owner
  end
  resources :deal_messages, only:[:create]
  end
  scope module: :under_deals do
  get :how_to_kit
  end
  resources :contacts, only:[:new, :create,:index,:show,:update]do
  post :confirm, action: :confirm_new, on: :new
  end
  scope module: :contacts do
  get :new_inquiry
  get :working_inquiry
  get :past_inquiry
  end

  resources :ads, only:[:index, :show]do
  resources :summary_items, only:[:index, :show, :create]
  member do
  get :genre_search
  get :favorite_search
  post :apply
  end
  resource :favorites, only: [:create, :destroy]
  end

end
