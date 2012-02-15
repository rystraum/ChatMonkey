Chat::Application.routes.draw do
  get "users/create"
  get "msgs/fetch"
  root :to => "pages#home"
  devise_for :users
  match "/dashboard" => "chatrooms#index", :as => :user_root

  resources :users do
    resources :chatrooms
  end

  resources :chatrooms do
    resources :msgs
    resources :users
  end

  resources :msgs
end
