Rails.application.routes.draw do 
  
  # Post Routes
  root "posts#index"

  resources :posts, except: [:index, :about]

  # user routes
  get "/signup", to: "users#new"
  get "/profile", to: "users#show"
  resources :users, only: [:create]

  # session routes
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"
  resources :sessions, only: [:create]

end
