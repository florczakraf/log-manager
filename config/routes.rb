Rails.application.routes.draw do
  get 'sessions/login'
  get 'sessions/logout'
  post 'sessions/login_attempt'

  get 'sessions/profile'

  get 'pages/welcome'
  get 'pages/update'
  get 'pages/servers'
  
  get 'players/all'
  match "players/all" => "players#all", :via => :post
  get 'players/filter'
  get 'players/ban'
  get 'players/id'

  get 'violations/index'
  match "violations/index" => "violations#index", :via => :post
  get 'violations/filter'
  
  
  get 'users/new'
  post 'users/create'
  
  match "signup", :to => "users#new", :via => :post
  #match "login", :to => "sessions#login"
  
#  match ':controller(/:action(/:id))(.:format)'
   #':controller(/:action(/:id))(.:format)'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#welcome'

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
