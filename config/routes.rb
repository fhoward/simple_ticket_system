Rails.application.routes.draw do

  resources :sessions, only: [:new, :create, :destory]
  resources :users, only: [:new, :create, :show, :index, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
