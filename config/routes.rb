Chat::Application.routes.draw do
  get "users/create"

  root :to => "pages#home"
  devise_for :users
  match "/dashboard" => "chatrooms#index", :as => :user_root

  resources :users, only: [:create] do
    resources :chatrooms
  end

  resources :chatrooms do
    resources :msgs, only: [:create]
    resources :users, only: [:create]
    member do
      get "full"
    end
  end

  resources :msgs, only: [] do
    collection do
      get "fetch"
    end
  end

  resources :suggestions, only: [:index, :create] do
    member do
      put "vote"
    end
  end
end

