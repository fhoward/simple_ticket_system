Rails.application.routes.draw do

  resources :tickets do
    resources :comments
    collection do
      post 'import'
      get 'export'
    end
  end


  get '/sessions', to: 'sessions#new', as: 'new_sign_in'
  post '/sign_in', to: 'sessions#create', as: 'sign_in'
  delete '/sign_out', to: 'sessions#destroy', as: 'sign_out'

  resources :users, only: [:new, :create, :show, :index, :update]
  root "tickets#index"
end
