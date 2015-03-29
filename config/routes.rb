Rails.application.routes.draw do
  get 'hashtags/show'

  root "confessions#index"

  resources :confessions do
    resources :comments
  end
  resources :hashtags
  resources :sessions
  resources :schools 

  match "user_school", to: "schools#show", as: "user_school", via: :get
  match "find_or_create_school", to: "schools#create", as: "find_or_create_school", via: :get
  match "/auth/facebook/callback", to: "sessions#create", as: "signin", via: :get
  match "/auth/failure", to: redirect("/"), via: :get
  match "signout", to: "sessions#destroy", as: "signout", via: :get
  
end
