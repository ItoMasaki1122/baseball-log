Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :destroy_confirm
    end
    collection do
      get :search
    end
  end
  
  resources :games, only: [:show, :new, :edit, :update, :create, :destroy] do
    resources :comments, only: [:new, :create, :destroy]
  end
  resources :favorites, only: [:new, :create, :update ]
  
end
