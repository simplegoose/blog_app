Rails.application.routes.draw do
  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:show, :index] do
    resources :posts, only: [:show, :index, :create, :new, :destroy] do
      resources :comments, only: [:create, :new, :destroy]
      resources :likes, only: [:create]
    end
  end
  resources :posts, only: [:create, :new]

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts, only: [:index, :create] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end