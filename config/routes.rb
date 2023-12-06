Rails.application.routes.draw do
  get '/sessions', to: 'sessions#new', as: 'new_sign_in'
  post '/sign_in', to: 'sessions#create', as: 'sign_in' 
  delete '/sign_out', to: 'sessions#destroy', as: 'sign_out'
 
  resources :users, only: [:new, :create, :show, :index, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
