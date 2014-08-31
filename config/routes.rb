require 'api_constraints'

DeviseApiRailsWorking::Application.routes.draw do

  resources :annotations

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :feedbacks

  get 'verifications/new'

  get 'verifications/verify'
  post 'verifications/verify'

  get 'verifications/create'
  post 'verifications/create'

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations" }
  
  get '/mu-b7a80520-38574f1d-8d74f9b9-cd358b57', :to => proc { |env| [200, {}, ["42"]] }
  root :to=>"feedbacks#index"
  
  namespace :api, {format: 'json'} do 
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      resources :sessions, :only => [:create, :destroy]
      resources :registrations, :only => [:create]

    end
    scope module: :v2, constraints: ApiConstraints.new(version: 2, default: :true) do
      devise_for :users, skip: :all
      devise_scope :user do
        post "/sessions" => "sessions#create"
        post "/registrations" => "registrations#create"
        delete "/sessions" => "sessions#destroy"
      end
      resources :sessions, :only => [:create, :destroy]
      resources :registrations, :only => [:create]

      post "/verifications/create" => "verifications#create"
      post "/verifications/verify" => "verifications#verify"

      post "/feedbacks/create" => "feedbacks#create"
      post "/feedbacks/display_all_listing" => "feedbacks#display_all_listing"
      post "/feedbacks/display_all_listing2" => "feedbacks#display_all_listing2"
      post "/feedbacks/display_details" => "feedbacks#display_details"

      post "/users/email_exists" => "users#email_exists"
      post "/users/facebook_login" => "users#facebook_login"
      post "/users/get_user" => "users#get_user"

      post "/annotations/create" => "annotations#create"
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
