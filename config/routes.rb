Rails.application.routes.draw do
  root 'pages#welcome'
  get 'pages/update'
  get 'sessions/login', as: 'login'
  get 'sessions/logout', as: 'logout'
  post 'sessions/login_attempt'
  
  resources :players do
    get :search, on: :collection
  end

  resources :servers do
    get :manage, on: :collection
  end
  
  resources :users do
    member do
      get :activate, :promote, :demote
    end
  end

  resources :violations do
    get :filter, on: :collection
  end
end
