Rails.application.routes.draw do
  get 'hashtags/show'

  # if user is logged in, root to user_school, else root to confession#index
  root "confessions#index"

  resources :confessions do
    resources :comments
  end
  resources :hashtags
  resources :sessions
  resources :schools 

  match "switch_school", to: "schools#switch", as: "switch_school", via: :get
  match "find_or_create_school", to: "schools#create", as: "find_or_create_school", via: :get
  match "/auth/facebook/callback", to: "sessions#create", as: "signin", via: :get
  match "/auth/failure", to: redirect("/"), via: :get
  match "signout", to: "sessions#destroy", as: "signout", via: :get
  
end
