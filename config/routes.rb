Rails.application.routes.draw do
  get 'servers/all'
  get 'servers/manage', as: 'manage_servers'
  post 'servers/add', as: 'add_server'
  get 'servers/removeserver/:id', to: 'servers#remove_server', as: 'remove_server'

  get 'sessions/login', as: 'login'
  get 'sessions/logout', as: 'logout'
  post 'sessions/login_attempt'

  get 'sessions/profile'

  get 'pages/welcome'
  get 'pages/update'
  
  get 'players/all'
  match "players/all" => "players#all", :via => :post
  get 'players/single/:id', to: 'players#single', as: 'player'

  
  get 'violations/all'
  get 'violations/single/:id', to: 'violations#single', as: 'violation'
  match "violations/all" => "violations#all", :via => :post
  
  
  get 'users/new', as: 'signup'
  get 'users/manage', as: 'manage_users'
  get 'users/activate/:id', to: 'users#activate', as: 'activate'
  get 'users/removeeuser/:id', to: 'users#remove_user', as: 'remove_user'
  get 'users/makeadmin/:id', to: 'users#make_admin', as: 'make_admin'
  get 'users/remveadmin/:id', to: 'users#remove_admin', as: 'remove_admin'
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
